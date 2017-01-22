//
//  GasManager.m
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/22/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "GasManager.h"
#import "GasStation.h"

@interface GasManager()
@property (strong,nonatomic) NSMutableArray *gasPlaces;
@end

@implementation GasManager{
    
}


- (void) getPlaceCompletion:(void(^)(NSMutableArray*))result{
    
    if(_gasPlaces == nil){
        _gasPlaces = [NSMutableArray array];
        FIRDatabaseReference *ref = [[FIRDatabase database] reference];
        
        [[[ref child:@"Places"] child:@"Gas"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            
            id value = snapshot.value;
            if([value isKindOfClass:[NSArray class]]){
                for(NSDictionary *dic in value){
                    GasStation *gas = [[GasStation alloc] initWithDic:dic];
                    [_gasPlaces addObject:gas];
                }
            }
            
        } withCancelBlock:^(NSError * _Nonnull error) {
            NSLog(@"%@", error.localizedDescription);
            result(nil);
        }];

        
    }else{
        result(_gasPlaces);
    }

}

@end
