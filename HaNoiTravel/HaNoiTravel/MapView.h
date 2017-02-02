//
//  MapView.h
//  HaNoiTravel
//
//  Created by Dreamup on 1/19/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"

@interface MapView : UIView

- (void) startLoadMapCompletion:(void(^)(BOOL done))completion;
- (void) resetMapAtAddress:(NSString*) address;
- (void) setPlaces:(NSMutableArray*)arrPlaces withIcon:(NSString*)iconName;
- (void) showDirection:(BOOL)show;


@end
