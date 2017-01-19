//
//  RootViewController.h
//  HaNoiTravel
//
//  Created by Dreamup on 1/13/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "DUSwipeMenuViewController.h"
#import "MenuViewController.h"

@interface RootViewController : DUSwipeMenuViewController

@property (strong,nonatomic) MenuViewController *menuVC;
@property (strong,nonatomic) UINavigationController *loginNavi;

@end
