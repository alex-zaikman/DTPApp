//
//  aszWebBrain.m
//  DTPApp
//
//  Created by alex zaikman on 7/7/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszWebBrain.h"



@interface aszWebBrain()


-(id) init;

@end

@implementation aszWebBrain

static aszWebBrain *the = nil;

+(aszWebBrain*)the
{
    if(the)
        return the;
    
    static dispatch_once_t pred;        // Lock
    dispatch_once(&pred, ^{             // This code is called at most once per app
        if(!the)
            the = [[aszWebBrain alloc] init];
    });
    
    return the;
}

-(id) init
{
    
    self = [super init];
    if(self){
        
        //load base
        NSURLRequest *request =[[NSURLRequest alloc]initWithURL:[[NSURL alloc]initWithString:API_URL]];
        _brain = [[UIWebView alloc]init];
        _brain.delegate=self;
        [_brain loadRequest:request];
        
    }
    return self;
}

-(NSString*)callJs:(NSString*)name withParams:(NSArray*)params call:(NSString *)callme
{
    NSMutableString *command = [[NSMutableString alloc]init];
    
    [command appendString:name];
    [command appendString:@"("];
    if(params){
        for (int i=0 ; i<[params count] ; i++){
            [command appendString:@"'"];
            [command appendString:params[i]];
            [command appendString:@"'"];
           
            if(i<[params count]-1)
                [command appendString:@","];
        }
    }
    if(callme){
        if(params) 
            [command appendString:@","];
        //[command appendString:@"'"];
        [command appendString:@"function(res){ callback(res,'"];
    
        [ command appendString:callme];
        
        [command appendString:@"'); }"];
    }
    [command appendString:@");"];
    
 return  [self.brain stringByEvaluatingJavaScriptFromString:command];
    
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

@end


