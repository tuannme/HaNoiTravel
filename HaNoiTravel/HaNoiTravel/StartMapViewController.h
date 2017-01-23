//
//  StartMapViewController.h
//  HaNoiTravel
//
//  Created by Dreamup on 1/23/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapView.h"

@interface StartMapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *districtLb;
@property (weak, nonatomic) IBOutlet UILabel *wardLb;
@property (weak, nonatomic) IBOutlet UITableView *districtTbView;
@property (weak, nonatomic) IBOutlet UITableView *wardTbView;
@property (weak, nonatomic) IBOutlet UIButton *nextBt;


@end
