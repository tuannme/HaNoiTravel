//
//  SpinnerView.h
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/11/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpinnerView : UIView

+ (id)shareInstance;

- (void) startAnimation;
- (void) stopAnimation;

@end
