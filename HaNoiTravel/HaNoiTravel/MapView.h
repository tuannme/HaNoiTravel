//
//  MapView.h
//  HaNoiTravel
//
//  Created by Dreamup on 1/19/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapView : UIView

- (void) startLoadMap;
- (void) resetMapAtAddress:(NSString*) address;
- (void) showDirection:(BOOL)show;

@end
