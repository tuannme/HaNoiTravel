//
//  PlaceViewController.m
//  HaNoiTravel
//
//  Created by Dreamup on 1/13/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "PlaceViewController.h"
#import "PlaceMapCell.h"

@interface PlaceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tbView;

@end

@implementation PlaceViewController{

    CGFloat frameW;
    CGFloat frameH;
    PlaceMapCell *placeMapCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    frameW = [[UIScreen mainScreen] bounds].size.width;
    frameH = [[UIScreen mainScreen] bounds].size.height;
    placeMapCell = [_tbView dequeueReusableCellWithIdentifier:@"PlaceMapCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return placeMapCell;
    
}




@end
