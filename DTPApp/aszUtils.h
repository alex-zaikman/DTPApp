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

+ (UIColor *) getRandomColor;

+(void) LOG:(NSString *)msg;

+(void) ERROR:(NSString *)err;

+(NSString*)getDomain;


@end
