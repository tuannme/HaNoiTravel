//
//  DirectionService.h
//  HaNoiTravel
//
//  Created by TRAMS on 8/10/16.
//  Copyright © 2016 DREAMUP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DirectionService : NSObject

- (void)setDirectionsQuery:(NSDictionary *)object withSelector:(SEL)selector
              withDelegate:(id)delegate;
- (void)retrieveDirections:(SEL)sel withDelegate:(id)delegate;
- (void)fetchedData:(NSData *)data withSelector:(SEL)selector
       withDelegate:(id)delegate;

@end
