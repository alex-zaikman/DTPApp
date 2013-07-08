//
//  aszWebBrain.m
//  DTPApp
//
//  Created by alex zaikman on 7/7/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszWebBrain.h"

#define BRAIN_URL @"http://....."  //TODO

@interface aszWebBrain() <UIWebViewDelegate>

@property (atomic,strong) UIWebView *brain;

@end

@implementation aszWebBrain

-(id) init{
    
    self = [super init];
    if(self){
        
        //load base
        NSURLRequest *request =[[NSURLRequest alloc]initWithURL:[[NSURL alloc]initWithString:BRAIN_URL]];
        _brain = [[UIWebView alloc]init];
        [_brain loadRequest:request];
        
    }
    return self;
}





/*injects js function with the name <functionName> into the current context loadded in the webView */
-(void)registerFunctionWithName:(NSString*)functionName{
    
    NSMutableString *command = [[NSMutableString alloc]init];
    
    [command appendString:@"var " ];
    
    [command appendString:functionName];
    
    [command appendString:@" = function(){  var iframe = document.createElement('IFRAME');     iframe.setAttribute('src', 'js-call:"];
    
    [command appendString:functionName];
    
    [command appendString:@"');     document.documentElement.appendChild(iframe);     iframe.parentNode.removeChild(iframe);     iframe = null; }"];
    
    [self.brain stringByEvaluatingJavaScriptFromString:command];
    
}




#pragma mark – call JS API

/*call js function from curently loadded context of the webView with optional(can be nil) params and call backs  !mined the order*/
-(void)exec:(NSString*)jsFunction withParams:(NSArray*)params onSuccessCall:(void (^)(NSString *)) success onFailureCall:(void (^)(NSString*)) faliure{
    
    NSMutableString *command=[[NSMutableString alloc]init];
    
    
    [command appendString:@"var result; "];
    
    [command appendString:@"var success = function(ret){result= 'successWith-'.concat(ret);}; "];
    
    [command appendString:@"var failed = function(ret){result= 'failedWith-'.concat(ret);}; "];
    
    [command appendString:jsFunction];
    [command appendString:@"( "];
    
    for(NSString* param in params){
        [command appendString:@"'"];
        [command appendString:param];
        [command appendString:@"' , "];
    }
    
    [command appendString:@" success , failed);  "];
    
    [command appendString:@"var returnHook=function(){return result }; "];
    
    [command appendString:@"returnHook();  "];
    
    NSString *ret=  [self.brain stringByEvaluatingJavaScriptFromString:command];
    
    if([ret hasPrefix:@"successWith-"]){
        
        if(success==nil)return;
        
        NSRange range = [ret rangeOfString:@"successWith-"];
        success([ret substringFromIndex:range.length]);
    }else{
        
        if(faliure==nil)return;
        
        NSRange range = [ret rangeOfString:@"failedWith-"];
        faliure([ret substringFromIndex:range.length]);
    }
    
    
    
    
}



#pragma mark – registered Ios Functions

-(void)functionInjectionTest{
    
    NSLog(@"%@",@"AOK");
    
}




//preset some JS hook functions here...
-(void)registerIosFunctions{
    
    [self registerFunctionWithName:@"functionInjectionTest"];
    
}






#pragma mark – UIWebViewDelegate


-(void) webViewDidFinishLoad:(UIWebView *)webView{

    static BOOL firstTime = YES;
    
    if(firstTime){
        
        [self registerIosFunctions];
        
        firstTime=NO;
    }




}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString  *requestString=[[request URL] absoluteString];
    
    // Intercept custom location change, URL begins with "js-call:"
    if ([requestString hasPrefix:@"js-call:"]) {
        
        // Extract the selector name from the URL
        NSArray *components = [requestString componentsSeparatedByString:@":"];
        NSString *function = [components objectAtIndex:1];
        
        // Call the given selector
        [self performSelector:NSSelectorFromString(function)];
        
        // Cancel the location change
        return NO;
    }
    
    // Accept this location change
    return YES;
    
    
}

@end
