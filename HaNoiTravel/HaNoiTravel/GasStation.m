//
//  GasStation.m
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/22/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "GasStation.h"
#import "User.h"
#import <CoreLocation/CoreLocation.h>

@implementation GasStation

- (id) initWithDic:(NSDictionary*)dic{
    
    self.name = dic[@"name"];
    self.address = dic[@"address"];
    //self.time = dic[@"time"];
    self.latitude = [dic[@"latitude"] floatValue];
    self.longitude = [dic[@"longitude"] floatValue];
    //self.star = [dic[@"star"] integerValue];

    CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:self.latitude longitude:self.longitude];
    CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:[[User shareInstance] latitude] longitude:[[User shareInstance] longitude]];
    _distance = [startLocation distanceFromLocation:endLocation]/1000;
    
    NSLog(@"distance = %f",_distance);
    
    self.distanceStr = [NSString stringWithFormat:@"%.1f km",_distance];
    
    return self;
}

@end
