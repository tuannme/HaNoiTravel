//
//  SlideMenuViewController.m
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/12/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "SlideMenuViewController.h"

@interface SlideMenuViewController ()

@end

@implementation SlideMenuViewController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    self.view.userInteractionEnabled = YES;
    swipeL.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeL];
    
    
    UISwipeGestureRecognizer *swipeR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    swipeR.direction = UISwipeGestureRecognizerDirectionRight;
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:swipeR];
    

    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _mainNavi = [sb instantiateViewControllerWithIdentifier:@"LoginNavi"];
    
    [self.view addSubview:_mainNavi.view];
    [self addChildViewController:_mainNavi];
    
    _leftViewController = [[UIViewController alloc] init];
    _leftViewController.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:_leftViewController.view];
    [self addChildViewController:_leftViewController];
    [self swipeLeft];
}

-(void)swipeGesture:(UISwipeGestureRecognizer*)swipe{
    
    if(swipe.direction == UISwipeGestureRecognizerDirectionLeft){
        [self swipeLeft];
    }else if (swipe.direction == UISwipeGestureRecognizerDirectionRight){
        [self swipeRight];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) swipeLeft{
    CGRect screen = [[UIScreen mainScreen] bounds];
    screen.origin.x = - screen.size.width;

    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
        _leftViewController.view.frame = screen;
    }completion:nil];
    
}

- (void) swipeRight{
    CGRect screen = [[UIScreen mainScreen] bounds];
    screen.origin.x = - 100;
    _leftViewController.view.frame = screen;
}

@end
