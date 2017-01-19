//
//  DUSwipeMenuViewController.h
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/19/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DUSwipeMenuViewController : UIViewController

@property (strong,nonatomic) UIViewController *leftViewController;
@property (strong,nonatomic) UINavigationController *mainNavi;

- (void) setLeftViewController:(UIViewController *)leftViewController;
- (void) setMainNavi:(UINavigationController *)mainNavi;
- (void) setSwipeEnable:(BOOL)enable;


@end
