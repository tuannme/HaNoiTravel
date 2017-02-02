//
//  SiriView.h
//  HaNoiTravel
//
//  Created by Dreamup on 2/2/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeechView : UIView

- (id) initWithBlock:(void(^)(NSString *result))completion;
- (void) start;

@property (weak, nonatomic) IBOutlet UIView *circleView;


@end
