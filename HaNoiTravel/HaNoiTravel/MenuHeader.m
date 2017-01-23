//
//  MenuHeader.m
//  HaNoiTravel
//
//  Created by Dreamup on 1/16/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "MenuHeader.h"
#import "AppDelegate.h"
#import "User.h"

@interface MenuHeader()

@property(strong,nonatomic) void (^completion)(BOOL);

@end

@implementation MenuHeader{
    
}

- (void) addBlockAction:(void(^)(BOOL))completion{
    self.completion = completion;
}

- (IBAction)logoutAction:(id)sender {
    
    if([[User shareInstance] email] != nil){
        [[User shareInstance] setEmail:nil];
        [[User shareInstance] setPassword:nil];
        [self.logoutBt setTitle:@"LOGIN" forState:UIControlStateNormal];
        _completion(NO);
    }else{
        _completion(YES);
    }
}
@end
