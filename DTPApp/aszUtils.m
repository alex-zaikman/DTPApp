//
//  aszUtils.m
//  DTPApp
//
//  Created by alex zaikman on 7/8/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszUtils.h"
#import "Base64.h"

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

+(NSArray*)jsonToArray:(NSString*)json
{
  
    NSError *error;
    
    NSString *myString = json;
    
    NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *ret =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
       
    return ret;
    
}

+(NSDictionary*)jsonToDictionarry:(NSString*)json
{
    
    NSError *error;
    
    NSString *myString = json; 
    
    NSData *data = [myString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *ret =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
  
    return ret;

}

+(NSString*) decodeFromPercentEscapeString:(NSString *)string {
    
    return (__bridge NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,  (__bridge CFStringRef) string,CFSTR(""), kCFStringEncodingUTF8);
    
}



+(NSURLRequest*)requestWithUrl:(NSString*)url usingMethod:(NSString*)method withUrlParams: (NSDictionary*)urlVars andBodyData:(NSString*)bodyData {
    
    NSString *vurl = url;
    
    if(urlVars!=nil && [urlVars count]>0){
        vurl = [vurl stringByAppendingString:@"?"];
        vurl = [vurl stringByAppendingString:[aszUtils paramsToString:urlVars]];
        
    }
    
    NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString: vurl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:90.0];
    
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    if( method!=nil)
        [request setHTTPMethod:method];
    
    if(bodyData!=nil)
        [request setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:[bodyData length]]];
    
    return [request copy];
}


+(NSString*)paramsToString:(NSDictionary*)vars{
    
    NSMutableString *getVars=[[NSMutableString alloc]init];
    
    //  [getVars appendString:@"?"];
    
    NSEnumerator *it = [vars keyEnumerator];
    
    for(NSString *aKey in it) {
        getVars = [[getVars stringByAppendingString:aKey]mutableCopy];
        getVars = [[getVars stringByAppendingString:@"="]mutableCopy];
        getVars = [[getVars stringByAppendingString:[vars valueForKey:aKey]]mutableCopy];
        getVars = [[getVars stringByAppendingString:@"&"]mutableCopy];
    }
    NSString*  ret = [getVars substringToIndex:[getVars length] - 1];
    
    return ret;
}


+(int)stringToInt:(NSString*)str{
    return [str intValue];
}
+(NSString*)intToString:(int)i{
    return  [NSString stringWithFormat:@"%d",i];
}


@end
