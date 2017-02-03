//
//  PlaceDetailViewController.m
//  HaNoiTravel
//
//  Created by Dreamup on 1/19/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "PlaceDetailViewController.h"
#import "MapView.h"
#import "GasManager.h"

@interface PlaceDetailViewController ()

@property (strong, nonatomic) IBOutlet MapView *mapView;

- (IBAction)backAction:(id)sender;

@end

@implementation PlaceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_mapView startLoadMapCompletion:nil];

}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    [[GasManager shareInstance] getPlaceCompletion:^(NSMutableArray *result){
        dispatch_async(dispatch_get_main_queue(), ^{
            [_mapView setPlaces:result withIcon:@"ic_gas.png"];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
