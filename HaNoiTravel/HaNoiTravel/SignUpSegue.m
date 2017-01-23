//
//  SignUpSegue.m
//  HaNoiTravel
//
//  Created by Dreamup on 1/11/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "SignUpSegue.h"

@implementation SignUpSegue

- (void)perform{
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    CGFloat screenW = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenH = [[UIScreen mainScreen] bounds].size.height;
    
    CGRect desFrame = CGRectMake(15, - screenH, screenW - 30, screenH );
    
    destinationViewController.view.frame = desFrame;
    
    // Add the destination view as a subview, temporarily
    [sourceViewController.view addSubview:destinationViewController.view];
    [sourceViewController addChildViewController:destinationViewController];
    
    desFrame.origin.y =  0;
    
    [UIView animateWithDuration:1.0f delay:0.0f usingSpringWithDamping:0.4f initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        destinationViewController.view.frame = desFrame;
    }completion:^(BOOL finished){
        
    }];
    
}

@end
