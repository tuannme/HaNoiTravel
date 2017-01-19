//
//  DUSpinnerView.m
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/19/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "DUSpinnerView.h"

static DUSpinnerView *spinner = nil;
static UIImageView *spinnerImv = nil;

@implementation DUSpinnerView{
    BOOL isFinish;
}

+ (id)shareInstance{
    
    if(spinner == nil){
        spinner = [[DUSpinnerView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        spinner.backgroundColor = [UIColor clearColor];
        
        /*
         UIView *blurView = [[UIView alloc] initWithFrame:spinner.frame];
         blurView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
         blurView.alpha = 0.5;
         [spinner addSubview:blurView];
         */
        
        spinnerImv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        spinnerImv.image = [UIImage imageNamed:@"spinner_blue.png"];
        spinnerImv.center = spinner.center;
        
        
        [spinner addSubview:spinnerImv];
    }
    return spinner;
}

- (void) startLoading{
    isFinish = NO;
    [self rotateSpinner];
    [[[[[UIApplication sharedApplication] keyWindow] rootViewController] view] addSubview:spinner];
}

- (void) stopLoading{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        isFinish = YES;
        [spinner removeFromSuperview];
    });
}

- (void)rotateSpinner{
    if(isFinish){
        return;
    }
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [spinnerImv setTransform:CGAffineTransformRotate(spinnerImv.transform, M_PI_2)];
    } completion:^(BOOL finished) {
        if (finished && !CGAffineTransformEqualToTransform(spinnerImv.transform, CGAffineTransformIdentity)) {
            [self rotateSpinner];
        }
    }];
}

@end
