//
//  MainViewController.m
//  HaNoiTravel
//
//  Created by TRAMS on 8/11/16.
//  Copyright © 2016 DREAMUP. All rights reserved.
//

#import "MainViewController.h"
#import "RootViewController.h"
#import "PlaceViewController.h"


@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIView *windowsView;

@property (weak, nonatomic) IBOutlet UIButton *grabTravelBtn;
@property (weak, nonatomic) IBOutlet UIButton *placeBtn;
@property (weak, nonatomic) IBOutlet UIButton *accountBtn;
@property (weak, nonatomic) IBOutlet UIView *slideLineView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *slideLineLeadingConstraint;


- (IBAction)grabTravelAction:(id)sender;
- (IBAction)placeAction:(id)sender;
- (IBAction)accountAction:(id)sender;

@end

#define COLOR_BTN_NORMAL [UIColor colorWithRed:120.0/255 green:120.0/255 blue:120.0/255 alpha:1]
#define COLOR_BTN_SELECTED [UIColor colorWithRed:60.0/255 green:60.0/255 blue:60.0/255 alpha:1]

@implementation MainViewController{
    CGFloat frameW;
    CGFloat frameH;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController *naviController = (UINavigationController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    RootViewController *rootVC = [[naviController viewControllers] objectAtIndex:0];
    [rootVC setSwipeEnable:YES];
    [rootVC.menuVC.tbView reloadData];
    
    frameH = [[UIScreen mainScreen] bounds].size.height;
    frameW = [[UIScreen mainScreen]bounds].size.width;
    
    _placeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _grabTravelBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
    _accountBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
    
    [_grabTravelBtn setTitleColor:COLOR_BTN_NORMAL forState:UIControlStateNormal];
    [_placeBtn setTitleColor:COLOR_BTN_SELECTED  forState:UIControlStateNormal];
    [_accountBtn setTitleColor:COLOR_BTN_NORMAL forState:UIControlStateNormal];

}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self placeAction:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)grabTravelAction:(id)sender {
    _grabTravelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _placeBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
    _accountBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
    
    [_grabTravelBtn setTitleColor:COLOR_BTN_SELECTED forState:UIControlStateNormal];
    [_placeBtn setTitleColor:COLOR_BTN_NORMAL forState:UIControlStateNormal];
    [_accountBtn setTitleColor:COLOR_BTN_NORMAL forState:UIControlStateNormal];
    
    
    [UIView animateWithDuration:0.2 animations:^{
        _slideLineLeadingConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)placeAction:(id)sender {
    _grabTravelBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
    _placeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _accountBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
    
    [_grabTravelBtn setTitleColor:COLOR_BTN_NORMAL forState:UIControlStateNormal];
    [_placeBtn setTitleColor:COLOR_BTN_SELECTED forState:UIControlStateNormal];
    [_accountBtn setTitleColor:COLOR_BTN_NORMAL forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.2 animations:^{
        _slideLineLeadingConstraint.constant = frameW/3;
         [self.view layoutIfNeeded];
    }];
}

- (IBAction)accountAction:(id)sender {
    _grabTravelBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
    _placeBtn.titleLabel.font = [UIFont systemFontOfSize:13.5];
    _accountBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    [_grabTravelBtn setTitleColor:COLOR_BTN_NORMAL forState:UIControlStateNormal];
    [_placeBtn setTitleColor:COLOR_BTN_NORMAL forState:UIControlStateNormal];
    [_accountBtn setTitleColor:COLOR_BTN_SELECTED forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.2 animations:^{
        _slideLineLeadingConstraint.constant = 2*frameW/3;
         [self.view layoutIfNeeded];
    }];
}


@end
