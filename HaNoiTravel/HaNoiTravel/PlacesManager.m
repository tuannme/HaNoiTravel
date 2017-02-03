//
//  PlacesManager.m
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/22/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "PlacesManager.h"
#import "Place.h"

@interface PlacesManager()


@end

@implementation PlacesManager

+(id) shareInstance{
    return self;
}

- (void) getPlaceCompletion:(void(^)(NSMutableArray*))result{
    
}

- (NSArray*) sortDistance:(NSArray*)arrOrigin;{
    NSArray *arraySort = [arrOrigin sortedArrayUsingComparator:^(id obj1, id obj2){
        Place *place1 = obj1;
        Place *place2 = obj2;
        
        if (place1.distance > place2.distance) {
            return (NSComparisonResult)NSOrderedDescending;
        } else if (place1.distance  < place2.distance) {
            return (NSComparisonResult)NSOrderedAscending ;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    return arraySort;
}




@end
