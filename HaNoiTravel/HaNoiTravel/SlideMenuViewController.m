//
//  SlideMenuViewController.m
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/12/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "SlideMenuViewController.h"

static CGFloat threshold = 250;

typedef enum {
    LEFT,
    RIGHT
}Direction;


@interface SlideMenuViewController (){
    CGFloat beginPosition;
    Direction direction;
    CGPoint beginPoint;
    BOOL swipeEnable;
}

@end

@implementation SlideMenuViewController{
    CGFloat screeW;
    CGPoint lastPoint;
}

- (void) setLeftViewController:(UIViewController *)leftViewController{
    _leftViewController = leftViewController;
    [self.view addSubview:_leftViewController.view];
    [self addChildViewController:_leftViewController];
    
    CGRect frame = _leftViewController.view.frame;
    frame.origin.x = - 100;
    _leftViewController.view.frame = frame;
    
}
- (void) setMainNavi:(UINavigationController *)mainNavi{
    _mainNavi = mainNavi;
    [self.view addSubview:_mainNavi.view];
    [self addChildViewController:_mainNavi];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screeW = [[UIScreen mainScreen] bounds].size.width;
    self.view.userInteractionEnabled = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"didReceiveMemoryWarning SlideMenu");
}

- (void) setSwipeEnable:(BOOL)enable{
    swipeEnable = enable;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
    UITouch *touch = [touches anyObject];
    beginPoint = [touch locationInView:self.view];
    lastPoint = beginPoint;
    beginPosition = _mainNavi.view.frame.origin.x;
    
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if(!swipeEnable){
        return;
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint nowPoint = [touch locationInView:self.view];
    
    if(nowPoint.x - lastPoint.x < 0){
        direction = LEFT;
    }else direction = RIGHT;
    lastPoint = nowPoint;
    
    CGFloat postion = nowPoint.x - beginPoint.x;
    
    
    if(beginPosition == 0){
        if(postion < 0 || postion > threshold){
            return;
        }
    }
    
    if(beginPosition == threshold){
        if(beginPoint.x < threshold){
            return;
        }
        postion = threshold + postion;
    }
    
    CGRect mainF = _mainNavi.view.frame;
    mainF.origin.x = postion;
    _mainNavi.view.frame = mainF;
    
    CGRect leftF = _leftViewController.view.frame;
    leftF.origin.x = (postion -100)/10;
    _leftViewController.view.frame = leftF;
    
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if(!swipeEnable){
        return;
    }
    
    if(_mainNavi.view.frame.origin.x != 0 || _mainNavi.view.frame.origin.x != threshold){
        CGRect endFrame = _mainNavi.view.frame;
        CGRect leftFrame = _leftViewController.view.frame;
        
        if(direction == RIGHT){
            endFrame.origin.x = threshold;
            leftFrame.origin.x = (threshold-100)/10;
        }else{
            endFrame.origin.x = 0;
            leftFrame.origin.x = -100;
        }
        
        [UIView animateWithDuration:0.3f delay:0 usingSpringWithDamping:0.3f
              initialSpringVelocity:0.4f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             _mainNavi.view.frame = endFrame;
                             _leftViewController.view.frame = leftFrame;
                         }completion:^(BOOL finished){
                             
                         }];
    }
}



@end
