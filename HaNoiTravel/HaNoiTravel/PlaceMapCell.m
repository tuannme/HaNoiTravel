//
//  PlaceMapCell.m
//  HaNoiTravel
//
//  Created by Dreamup on 1/19/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "PlaceMapCell.h"
#import "DUSearchBar.h"

@interface PlaceMapCell()

@property (weak, nonatomic) IBOutlet MapView *mapView;

- (IBAction)searchAction:(id)sender;
- (IBAction)voiceAction:(id)sender;

@end

@implementation PlaceMapCell{
    void (^searchResult)(NSString*result);
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [_mapView startLoadMap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)searchAction:(id)sender {
    
    [[DUSearchBar shareInstance] showWithFrame:CGRectMake(0, 110, [[UIScreen mainScreen] bounds].size.width, 60)];
    
    if(searchResult!= nil){
        
    }
    
}

- (IBAction)voiceAction:(id)sender {
}

- (void) searchCompletion:(void(^)(NSString*))result{
    searchResult = result;
}

@end
