//
//  aszT2KApi.m
//  DTPApp
//
//  Created by alex zaikman on 8/4/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszT2KApi.h"
#import "aszWebBridge.h"
#import "aszUtils.h"

@interface aszT2KApi() <UIWebViewDelegate>

@property (nonatomic,strong) void (^successCall)(NSString*);
-(void)aok:(NSString*)msg;
@property (nonatomic,strong) void (^falureCall)(NSString*);
-(void)ono:(NSString*)msg;

@end

@implementation aszT2KApi

-(void)ono:(NSString*)msg{
    if(self.falureCall)
        self.falureCall( msg);
}


-(void)aok:(NSString*)msg{
    if(self.successCall)
        self.successCall( msg);
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString  *requestString=[[request URL] absoluteString];
    
    if ([requestString hasPrefix:@"http://js-call"]) {
        
        // Extract the selector name from the URL
        NSArray *components = [requestString componentsSeparatedByString:DELEMITER];
      
        NSString *function = [components objectAtIndex:1];
        NSString *key = [components objectAtIndex:2];
        
        NSMutableString *fetchCommand=[[NSMutableString alloc]init];
        
        [fetchCommand appendString:@"echoForKey('" ];
        [fetchCommand appendString: key ];
        [fetchCommand appendString:@"');" ];
        
        NSString *param = [webView stringByEvaluatingJavaScriptFromString:fetchCommand];
    
    

        
        
        // Call the given selector
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:NSSelectorFromString(function) withObject:param];
        
        // Cancel the location change
        return NO;
    }
    
    // Accept this location change
    return YES;
    
    
}


#pragma mark JS API
+(void) loadOnSuccess:(void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure{
    
    aszWebBridge *instance = [aszWebBridge the];

    
    static aszT2KApi  *me;
    if(!me){
        me = [[aszT2KApi alloc]init];
    }
    me.successCall=success;
    me.falureCall=faliure;
    
    [instance setCustomDelegate:me];
    
     NSArray *param=@[@"'html5'"];
    
    [instance callJs:@"T2K.api.load" withParams:param OnSucsses:@"aok:" OnFaliure:@"ono:"];
    
    
    
}

+(void) initOnSuccess:(void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure{
    
    aszWebBridge *instance = [aszWebBridge the];
    
    
    static aszT2KApi  *me;
    if(!me){
        me = [[aszT2KApi alloc]init];
    }
    me.successCall=success;
    me.falureCall=faliure;
    
    [instance setCustomDelegate:me];
    
    [instance callJs:@"T2K.server.initData" withParams:nil OnSucsses:@"aok:" OnFaliure:@"ono:"];
    
}




+(void) logInWithUser:(NSString*)user andPassword:(NSString*)pass OnSuccess:(void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure
{
    aszWebBridge *instance = [aszWebBridge the];
    
    user = [[@"'" stringByAppendingString:user]stringByAppendingString:@"'"];
    pass = [[@"'" stringByAppendingString:pass]stringByAppendingString:@"'"];
    
    NSArray *param=@[user,pass];
    
    
    static aszT2KApi  *me;
    if(!me){
        me = [[aszT2KApi alloc]init];
    }
    me.successCall=success;
    me.falureCall=faliure;
    
    [instance setCustomDelegate:me];
    
    [instance callJs:@"T2K.user.login" withParams:param OnSucsses:@"aok:" OnFaliure:@"ono:"];
 
    
}


+(void) logOutOnSuccess:(void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure
{
    static aszT2KApi  *me;
    if(!me){
        me = [[aszT2KApi alloc]init];
    }
    me.successCall=success;
    me.falureCall=faliure;
    
    [[aszWebBridge the] setCustomDelegate:me];
    
    [[aszWebBridge the] callJs:@"T2K.user.logout"  withParams:nil  OnSucsses:@"aok:" OnFaliure:@"ono:"];
}

+(void) getStudyClassesOnSuccess:(void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure
{
    
    
    static aszT2KApi  *me;
    if(!me){
        me = [[aszT2KApi alloc]init];
    }
    me.successCall=success;
    me.falureCall=faliure;
    
    [[aszWebBridge the] setCustomDelegate:me];
    
    [[aszWebBridge the] callJs:@"T2K.user.getStudyClasses"  withParams:nil  OnSucsses:@"aok:" OnFaliure:@"ono:"];
}

+(void) getCourse:(NSString*)cid  OnSuccess:(void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure{
    static aszT2KApi  *me;
    if(!me){
        me = [[aszT2KApi alloc]init];
    }
    me.successCall=success;
    me.falureCall=faliure;
    
    [[aszWebBridge the] setCustomDelegate:me];
    
    [[aszWebBridge the] callJs:@"T2K.content.getCourseByClass"  withParams:@[cid]  OnSucsses:@"aok:" OnFaliure:@"ono:"];
}

+(void) getLessonContent:(NSString*)courseId forLesson:(NSString*)lessonId  OnSuccess:(void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure
{
    static aszT2KApi  *me;
    if(!me){
        me = [[aszT2KApi alloc]init];
    }
    
    courseId = [[@"'" stringByAppendingString:courseId]stringByAppendingString:@"'"];
    lessonId = [[@"'" stringByAppendingString:lessonId]stringByAppendingString:@"'"];
    NSArray *param=@[courseId,lessonId];
    
    me.successCall=success;
    me.falureCall=faliure;
    
    [[aszWebBridge the] setCustomDelegate:me];
    
    [[aszWebBridge the] callJs:@"T2K.content.getLessonContent"  withParams:param  OnSucsses:@"aok:" OnFaliure:@"ono:"];
}



@end
