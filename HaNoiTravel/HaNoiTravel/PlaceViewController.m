//
//  PlaceViewController.m
//  HaNoiTravel
//
//  Created by Dreamup on 1/13/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "PlaceViewController.h"
#import "MapCell.h"
#import "PlaceCell.h"
#import "GasPlaceCell.h"
#import "GasManager.h"
#import "BankManager.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
#import <FirebaseAuth/FirebaseAuth.h>

@interface PlaceViewController ()<UITableViewDelegate,UITableViewDataSource,PlaceMapCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tbView;

@end

@implementation PlaceViewController{
    
    CGFloat frameW;
    CGFloat frameH;
    MapCell *placeMapCell;
    Places cureentPlaces;

    NSMutableArray *arrResult;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    frameW = [[UIScreen mainScreen] bounds].size.width;
    frameH = [[UIScreen mainScreen] bounds].size.height;
    placeMapCell = [_tbView dequeueReusableCellWithIdentifier:@"MapCell"];
    placeMapCell.delegate = self;
    [placeMapCell searchCompletion:^(NSString *result){
        
    }];
    
    _tbView.estimatedRowHeight = 240;
    _tbView.rowHeight = UITableViewAutomaticDimension;
    
    [[GasManager shareInstance] getPlaceCompletion:^(NSMutableArray *result){
        arrResult = result;
        dispatch_async(dispatch_get_main_queue(), ^{
            [placeMapCell.mapView setPlaces:arrResult withIcon:@"ic_gas.png"];
            [self.tbView reloadData];
        });
    }];
    
    [[BankManager shareInstance] getPlaceCompletion:^(NSMutableArray *result){
        //arrGas = result;
        dispatch_async(dispatch_get_main_queue(), ^{
            [placeMapCell.mapView setPlaces:arrResult withIcon:@"ic_bidv.png"];
            [self.tbView reloadData];
        });
    }];
    
    
    
    
    
}

- (void)didFilterCompleted:(Places)place{
    cureentPlaces = place;
    [self.tbView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        return 1;
    }
    
    switch (cureentPlaces) {
        case GAS:
            return arrResult.count;
            break;
        default:
            return 10;
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        return placeMapCell;
    }
    
    UITableViewCell *cell = nil;
    
    switch (cureentPlaces) {
        case GAS:
            cell = [_tbView dequeueReusableCellWithIdentifier:@"GasPlaceCell"];
            [(GasPlaceCell*)cell configWithGasStatin:[arrResult objectAtIndex:indexPath.row]];
            break;
            
        default:
            cell = [_tbView dequeueReusableCellWithIdentifier:@"PlaceCell"];
            break;
    }
    return cell;
}




@end
