//
//  aszUtils.m
//  DTPApp
//
//  Created by alex zaikman on 7/8/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszUtils.h"


@implementation aszUtils

#pragma mark - consts
NSString const * const domain_def=@"domain_def";
NSString const * const username_def=@"username_def";
NSString const * const password_def=@"password_def";


#pragma mark - util funcs


+ (UIColor *) getRandomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+(NSString*)getDomain
{
    
    NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:[domain_def copy]];
    return domain;
    
}




#pragma mark - debug funcs

+(void) LOG:(NSString *)msg
{
    if(DEBUG)
        NSLog(@"asz - msg: %@",msg);
}

+(void) ERROR:(NSString *)err
{
    if(DEBUG)
        NSLog(@"asz - error: %@",err);
}



@end
