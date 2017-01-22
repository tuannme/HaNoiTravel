//
//  PlacesManager.h
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/22/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FirebaseDatabase/FirebaseDatabase.h>

@interface PlacesManager : NSObject
- (void) getPlaceCompletion:(void(^)(NSMutableArray*))result;

@end
