//
//  MenuViewController.m
//  HaNoiTravel
//
//  Created by Dreamup on 1/13/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuCell.h"
#import "MenuHeader.h"
#import "User.h"

@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource>



@end

@implementation MenuViewController{
    CGFloat frameW;
    CGFloat frameH;
    ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    frameH = [[UIScreen mainScreen] bounds].size.height;
    frameW = [[UIScreen mainScreen] bounds].size.width;
    
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(-10, 20, frameW, frameH)];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];

    [_tbView registerNib:[UINib nibWithNibName:@"MenuCell" bundle:nil] forCellReuseIdentifier:@"MenuCell"];
    _tbView.backgroundColor = [UIColor clearColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    MenuHeader *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MenuHeader" owner:self options:nil] objectAtIndex:0];
    headerView.avatarImv.image = [UIImage imageNamed:@"ic_google.png"];
    headerView.nameLb.text = [[User shareInstance] displayName];
    headerView.avatarImv.layer.cornerRadius = 25;
    headerView.avatarImv.clipsToBounds = YES;
    
    if([[User shareInstance] photoURL]){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[[User shareInstance] photoURL]]];
            NSLog(@"photo download OK");
            dispatch_async(dispatch_get_main_queue(), ^{
                headerView.avatarImv.image = image;
                headerView.avatarImv.contentMode = UIViewContentModeScaleAspectFill;
            });
            
        });
    }
    return headerView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}



@end
