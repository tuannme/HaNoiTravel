//
//  User.m
//  HaNoiTravel
//
//  Created by Dreamup on 1/16/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "User.h"

static User *user = nil;


@implementation User{
   
}

@synthesize latitude;

+ (id) shareInstance{
    if(user == nil){
        user = [[User alloc] init];
    }
    return user;
}



@end
