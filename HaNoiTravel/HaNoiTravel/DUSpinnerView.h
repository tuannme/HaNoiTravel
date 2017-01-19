//
//  DUSpinnerView.h
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/19/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DUSpinnerView : UIView

+ (id)shareInstance;

- (void) startLoading;
- (void) stopLoading;

@end
