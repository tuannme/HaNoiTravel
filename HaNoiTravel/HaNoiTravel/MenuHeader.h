//
//  MenuHeader.h
//  HaNoiTravel
//
//  Created by Dreamup on 1/16/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuHeader : UIView

@property (weak, nonatomic) IBOutlet UIImageView *avatarImv;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UIButton *logoutBt;

- (IBAction)logoutAction:(id)sender;

- (void) addBlockAction:(void(^)(BOOL))completion;

@end
