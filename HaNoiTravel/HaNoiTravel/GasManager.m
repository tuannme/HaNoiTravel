//
//  GasManager.m
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/22/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "GasManager.h"
#import "GasStation.h"

static GasManager *gasManager = nil;

@interface GasManager()

@property (strong,nonatomic) NSMutableArray *gasPlaces;

@end

@implementation GasManager{
    
}

+(id) shareInstance{
    
    if(gasManager == nil){
        gasManager = [[GasManager alloc] init];
    }
    
    return gasManager;
}

- (void) getPlaceCompletion:(void(^)(NSMutableArray*))result{
    
    if(_gasPlaces == nil){

        FIRDatabaseReference *ref = [[FIRDatabase database] reference];
        
        [[[ref child:@"Places"] child:@"Gas"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            
            NSMutableArray *arrGas = [NSMutableArray array];
            
            id value = snapshot.value;
            
            for(NSDictionary *dic in [value allValues]){
                GasStation *gas = [[GasStation alloc] initWithDic:dic];
                [arrGas addObject:gas];
            }
       
            _gasPlaces = [NSMutableArray arrayWithArray:[self sortDistance:arrGas]];
            result(_gasPlaces);
            
        } withCancelBlock:^(NSError * _Nonnull error) {
            NSLog(@"%@", error);
            result(nil);
        }];

        
    }else{
        result(_gasPlaces);
    }

}




@end
