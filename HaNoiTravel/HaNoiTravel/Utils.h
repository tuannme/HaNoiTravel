//
//  Utils.h
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/11/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject
+ (void)showAlert:(NSString *)title message:(NSString *)message;
+ (void) showAlert:(NSString*)title message:(NSString*)message completion:(void(^)(BOOL))action;

@end
