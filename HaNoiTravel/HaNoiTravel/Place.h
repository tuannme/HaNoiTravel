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

@property (assign,nonatomic) CGFloat distance;
@property (strong,nonatomic) NSString *distanceStr;

@end
