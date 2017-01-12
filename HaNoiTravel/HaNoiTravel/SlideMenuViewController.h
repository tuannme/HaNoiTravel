//
//  SlideMenuViewController.h
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/12/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideMenuViewController : UIViewController

@property (strong,nonatomic) UIViewController *leftViewController;
@property (strong,nonatomic) UINavigationController *mainNavi;

- (void) swipeLeft;

@end
