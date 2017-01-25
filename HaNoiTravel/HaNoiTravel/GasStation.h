//
//  GasStation.h
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/22/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Place.h"

@interface GasStation : Place

- (id) initWithDic:(NSDictionary*)dic;


@property (strong,nonatomic) NSString *address;
@property (strong,nonatomic) NSString *time;

@end
