//
//  GasStation.h
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/22/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GasStation : NSObject

- (id) initWithDic:(NSDictionary*)dic;

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *address;
@property (strong,nonatomic) NSString *time;

@property (assign,nonatomic) CGFloat latitude;
@property (assign,nonatomic) CGFloat longitude;
@property (assign,nonatomic) NSInteger star;

@property (assign,nonatomic) CGFloat distance;
@property (strong,nonatomic) NSString *distanceStr;

@end
