//
//  PlaceMapCell.m
//  HaNoiTravel
//
//  Created by Dreamup on 1/19/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "MapCell.h"
#import "SpeechView.h"

@interface MapCell()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *keywordTf;

@end

@implementation MapCell{
    void (^searchResult)(NSString*result);
    NSMutableArray *arrFilter;
    UIView * circleView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [_mapView startLoadMapCompletion:nil];
    
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.hidden = YES;
    
    _searchBar.layer.masksToBounds = NO;
    _searchBar.layer.shadowOpacity = 1.f;
    _searchBar.layer.shadowOffset = CGSizeMake(0, 3);
    _searchBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.keywordTf.delegate = self;
    
    arrFilter = [NSMutableArray arrayWithObjects:@"Gas station",@"Hotel",@"ATM", nil];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void) searchCompletion:(void(^)(NSString*))result{
    searchResult = result;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.tbView.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

#pragma mark - Search Bar

- (IBAction)filterAction:(id)sender {
    self.tbView.hidden = NO;
}

- (IBAction)deleteAction:(id)sender {
    self.keywordTf.text = @"";
}

- (IBAction)voiceAction:(id)sender {
    SpeechView *speechView = [[SpeechView alloc] initWithBlock:^(NSString *result){
        
    }];
    [speechView start];
}




#pragma mark - UITableVIew

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrFilter.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [arrFilter objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tbView.hidden = YES;
    [self.delegate didFilterCompleted:(int)indexPath.row];
}



@end
