//
//  Bank.m
//  HaNoiTravel
//
//  Created by Dreamup on 2/3/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "Bank.h"
#import "User.h"
#import <CoreLocation/CoreLocation.h>

@implementation Bank

- (id) initWithDic:(NSDictionary*)dic{
    
    self.name = dic[@"name"];
    self.address = dic[@"address"];
    //self.time = dic[@"time"];
    self.latitude = [dic[@"latitude"] floatValue];
    self.longitude = [dic[@"longitude"] floatValue];
    //self.star = [dic[@"star"] integerValue];
    
    CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:self.latitude longitude:self.longitude];
    CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:[[User shareInstance] latitude] longitude:[[User shareInstance] longitude]];
    self.distance = [startLocation distanceFromLocation:endLocation]/1000;
    
    self.distanceStr = [NSString stringWithFormat:@"%.1f km",self.distance];
    
    return self;
}


@end
