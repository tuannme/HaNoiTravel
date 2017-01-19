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

- (IBAction)searchAction:(id)sender;
- (IBAction)voiceAction:(id)sender;

@property (weak, nonatomic) IBOutlet MapView *mapView;

@end
