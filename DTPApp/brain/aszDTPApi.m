//
//  aszDTPApi.m
//  DTPApp
//
//  Created by alex zaikman on 7/11/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszDTPApi.h"
#import "aszWebBrain.h"


@implementation aszDTPApi

+(void) logIn:(NSString*)domain withUser:(NSString*)user andPassword:(NSString*)pass onSuccessCall:(void (^)(NSString *))success onFaliureCall:(void (^)(NSString *))faliure
{
    
#warning not implemented
    
    success(@"loggged in");
    
}

+(void) logOutonSuccessCall:(void (^)(NSString *))success onFaliureCall:(void (^)(NSString *))faliure ;
{
    
#warning not implemented
    
    success(@"loggged out");
    
}

@end
