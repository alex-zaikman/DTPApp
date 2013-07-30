  //
//  aszDTPApi.m
//  DTPApp
//
//  Created by alex zaikman on 7/11/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszDTPApi.h"
#import "aszWebBrain.h"
#import "CDVWebViewDelegate.h"


@interface aszDTPApi()

@property (nonatomic,strong) void (^callback)(NSString*);

-(void)doit:(NSString*)msg;

@end

@implementation aszDTPApi



-(void)doit:(NSString*)msg{
    self.callback( msg);
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString  *requestString=[[request URL] absoluteString];
    
   // NSString* newStr = [[NSString alloc] initWithData:[request HTTPBody]
  //                                           encoding:NSUTF8StringEncoding];
    
    // Intercept custom location change, URL begins with "js-call:"
    if ([requestString hasPrefix:@"http://js-call"]) {
        
        // Extract the selector name from the URL
        NSArray *components = [requestString componentsSeparatedByString:@";:;:;"];
        NSString *function = [components objectAtIndex:1];
        
        NSString *test = [webView stringByEvaluatingJavaScriptFromString:@"echo()"];
        
        
        NSString *param = test; //= [components objectAtIndex:2];
        
        //param = [newStr stringByReplacingOccurrencesOfString:[param stringByAppendingString:@"="] withString:@""];
        
        
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

+(void) logInWithUser:(NSString*)user andPassword:(NSString*)pass callBack:(void (^)(NSString *))callme
{
    [aszWebBrain the];
    
    user = [[@"'" stringByAppendingString:user]stringByAppendingString:@"'"];
    pass = [[@"'" stringByAppendingString:pass]stringByAppendingString:@"'"];
    
    NSArray *param=@[user,pass];
    static aszDTPApi  *me;
    if(!me){
        me = [[aszDTPApi alloc]init];
    }
    me.callback=callme;

    [aszWebBrain the].cdvbrain.customDelegate = me;
    
    [[aszWebBrain the] callJs:@"T2K.user.login"  withParams:param call:@"doit:"];
}

+(void) logOutCall:(void (^)(NSString *))callme
{
    static aszDTPApi  *me;
    if(!me){
        me = [[aszDTPApi alloc]init];
    }
    me.callback=callme;

    [aszWebBrain the].cdvbrain.customDelegate = me;
    
    [[aszWebBrain the] callJs:@"T2K.user.logout"  withParams:nil call:@"doit:"];
}

+(void) getStudyClassesCall:(void (^)(NSString *))callme
{
 
    
    static aszDTPApi  *me;
    if(!me){
        me = [[aszDTPApi alloc]init];
    }
    me.callback=callme;
   
    [aszWebBrain the].cdvbrain.customDelegate = me;
    
    [[aszWebBrain the] callJs:@"T2K.user.getStudyClasses"  withParams:nil call:@"doit:"];
}

+(void) getCourse:(NSString*)cid Call:(void (^)(NSString *))callme
{
    static aszDTPApi  *me;
    if(!me){
        me = [[aszDTPApi alloc]init];
    }
    me.callback=callme;
    
    [aszWebBrain the].cdvbrain.customDelegate = me;
    
    [[aszWebBrain the] callJs:@"T2K.content.getCourseByClass"  withParams:@[cid] call:@"doit:"];
}

+(void) getLessonContent:(NSString*)courseId forLesson:(NSString*)lessonId Call:(void (^)(NSString *))callme
{
    static aszDTPApi  *me;
    if(!me){
        me = [[aszDTPApi alloc]init];
    }
    
    courseId = [[@"'" stringByAppendingString:courseId]stringByAppendingString:@"'"];
    lessonId = [[@"'" stringByAppendingString:lessonId]stringByAppendingString:@"'"];
    NSArray *param=@[courseId,lessonId];
    
    me.callback=callme;
    
    [aszWebBrain the].cdvbrain.customDelegate = me;
    
    [[aszWebBrain the] callJs:@"T2K.content.getLessonContent"  withParams:param call:@"doit:"];
}



@end

