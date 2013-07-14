//
//  aszDTPApi.h
//  DTPApp
//
//  Created by alex zaikman on 7/11/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface aszDTPApi : NSObject

+(void) logIn:(NSString*)domain withUser:(NSString*)user andPassword:(NSString*)pass onSuccessCall:(void (^)(NSString *))success onFaliureCall:(void (^)(NSString *))faliure ;


+(void) logOutonSuccessCall:(void (^)(NSString *))success onFaliureCall:(void (^)(NSString *))faliure ;


@end
