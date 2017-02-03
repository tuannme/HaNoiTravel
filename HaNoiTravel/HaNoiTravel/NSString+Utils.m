//
//  NSString+Utils.m
//  HaNoiTravel
//
//  Created by Nguyen Manh Tuan on 1/11/17.
//  Copyright © 2017 DREAMUP. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

-(BOOL)isValidEmail
{
    BOOL stricterFilter = NO; 
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}



@end
