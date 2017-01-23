//
//  User.h
//  HaNoiTravel
//
//  Created by Dreamup on 1/16/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface User : NSObject

+ (id) shareInstance;

@property (strong,nonatomic ) NSString *displayName;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *password;
@property (strong,nonatomic) NSURL *photoURL;

@property (assign,nonatomic) CGFloat latitude;
@property (assign,nonatomic) CGFloat longitude;

@end
