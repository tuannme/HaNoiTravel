//
//  PlaceMapCell.h
//  HaNoiTravel
//
//  Created by Dreamup on 1/19/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapView.h"


@interface PlaceMapCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (weak, nonatomic) IBOutlet UIView *searchBar;

- (void) searchCompletion:(void(^)(NSString*))result;

@end
