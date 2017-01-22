//
//  GasStation.m
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/22/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "GasStation.h"

@implementation GasStation

- (id) initWithDic:(NSDictionary*)dic{
    
    self.name = dic[@"name"];
    self.address = dic[@"address"];
    //self.time = dic[@"time"];
    self.latitude = [dic[@"latitude"] floatValue];
    self.longitude = [dic[@"longitude"] floatValue];
    //self.star = [dic[@"star"] integerValue];

    return self;
}

@end
