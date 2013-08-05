//
//  aszWebBridge.m
//  DTPApp
//
//  Created by alex zaikman on 8/4/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszWebBridge.h"
//#import "CDVViewController.h"

@interface aszWebBridge() <UIWebViewDelegate>

#define T2KAPI_URL @"http://cto.timetoknow.com/lms/js/libs/t2k/t2k.html"  

-(id) init;

@end

@implementation aszWebBridge

static aszWebBridge *the = nil;

+(aszWebBridge*)the
{
    if(the)
        return the;
    
    static dispatch_once_t pred;        // Lock
    dispatch_once(&pred, ^{             // This code is called at most once per app
        if(!the)
            the = [[aszWebBridge alloc] init];
    });
    
    return the;
}


-(void)setCustomDelegate:(id<UIWebViewDelegate>)delegate{
    
    self.cdvbrain.customDelegate = delegate;
}

-(id) init
{
    
    self = [super init];
    if(self){
    
        //init cordovat
        
        
        _cdvbrain = [CDVViewController new];
        
        
        _cdvbrain.customDelegate=self;
        
        _cdvbrain.wwwFolderName = @"";
        _cdvbrain.startPage = T2KAPI_URL;
        
        _cdvbrain.view.frame =CGRectMake(0,0, 900, 900);
    
        
    }
    return self;
}

-(NSString*)callJs:(NSString*)name withParams:(NSArray*)params OnSucsses:(NSString *)sucsses OnFaliure:(NSString *)faliure;
{
    NSMutableString *command = [[NSMutableString alloc]init];
    
    [command appendString:name];
    [command appendString:@"("];
    if(params){
        for (int i=0 ; i<[params count] ; i++){
            
            [command appendString:params[i]];
            
            if(i<[params count]-1)
                [command appendString:@","];
        }
    }
    if(sucsses){
        if(params)
            [command appendString:@","];
        
        
        [command appendString:@"function(res){ callback(res,'"];
        
        [ command appendString:sucsses];
        
        [command appendString:@"'); }"];
        
        if(faliure){
            
            [command appendString:@",function(res){ callback(res,'"];
            
            [ command appendString:faliure];
        
            [command appendString:@"'); }"];
        }
        
    }
    [command appendString:@");"];
    
    return  [self.cdvbrain.webView stringByEvaluatingJavaScriptFromString:command];
    
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

@end
