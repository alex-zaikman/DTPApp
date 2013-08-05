//
//  aszUtils.h
//  DTPApp
//
//  Created by alex zaikman on 7/8/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface aszUtils : NSObject


extern NSString const * const domain_def;
extern NSString const * const username_def;
extern NSString const * const password_def;


+(NSDictionary*)jsonToDictionarry:(NSString*)json;

+(NSArray*)jsonToArray:(NSString*)json;

+ (UIColor *) getRandomColor;

+(NSString*)getDomain;

+(NSString*) decodeFromPercentEscapeString:(NSString *)string ;

+(NSURLRequest*)requestWithUrl:(NSString*)url usingMethod:(NSString*)method withUrlParams: (NSDictionary*)urlVars andBodyData:(NSString*)bodyData;

+(NSString*)paramsToString:(NSDictionary*)vars;


@end
