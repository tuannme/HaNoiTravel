//
//  PlaceMapCell.h
//  HaNoiTravel
//
//  Created by Dreamup on 1/19/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapView.h"

typedef enum{
    GAS,
    HOTEL,
    ATM
}Places;


@protocol PlaceMapCellDelegate <NSObject>

- (void) didFilterCompleted:(Places)place;

@end

@interface PlaceMapCell : UITableViewCell

@property (weak,nonatomic) id<PlaceMapCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet MapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (weak, nonatomic) IBOutlet UIView *searchBar;

- (void) searchCompletion:(void(^)(NSString*))result;

@end
