//
//  BankManager.m
//  HaNoiTravel
//
//  Created by Dreamup on 2/3/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "BankManager.h"

static BankManager *bankManager = nil;

@interface BankManager ()

@property (strong,nonatomic) NSMutableArray *places;

@end

@implementation BankManager



+(id) shareInstance{
    
    if(bankManager == nil){
        bankManager = [[BankManager alloc] init];
    }
    
    return bankManager;
}

- (void) getPlaceCompletion:(void(^)(NSMutableArray*))result{
    
    if(_places == nil){
        
        FIRDatabaseReference *ref = [[FIRDatabase database] reference];
        
        [[[ref child:@"Places"] child:@"Gas"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            
            NSMutableArray *arrBanks = [NSMutableArray array];
            
            id value = snapshot.value;
            
            for(NSDictionary *dic in [value allValues]){
                Bank *bank = [[Bank alloc] initWithDic:dic];
                [arrBanks addObject:bank];
            }
            
            _places = [NSMutableArray arrayWithArray:[self sortDistance:arrBanks]];
            result(_places);
            
        } withCancelBlock:^(NSError * _Nonnull error) {
            NSLog(@"%@", error);
            result(nil);
        }];
        
        
    }else{
        result(_places);
    }
    
}


@end
