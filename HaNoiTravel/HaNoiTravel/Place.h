//
//  Place.h
//  HaNoiTravel
//
//  Created by Dreamup on 1/25/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Place : NSObject

@property (strong,nonatomic) NSString *name;

@property (assign,nonatomic) CGFloat latitude;
@property (assign,nonatomic) CGFloat longitude;
@property (assign,nonatomic) NSInteger star;

@property (strong,nonatomic) NSString *address;

@property (assign,nonatomic) CGFloat distance;
@property (strong,nonatomic) NSString *distanceStr;

@property (strong,nonatomic) NSString *time;

- (id) initWithDic:(NSDictionary*)dic;


@end
