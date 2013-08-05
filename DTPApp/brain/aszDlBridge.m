//
//  aszDlBridge.m
//  DTPApp
//
//  Created by alex zaikman on 8/4/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszDlBridge.h"

#define DL_API_URL   @"http://cto.timetoknow.com/cms/player/dl/index2.html"
#define DELEMITER @";:;:;"
#define DL_BRIDGE_TOO_SOON @"prematureApiCall"
#define DL_BRIDGE_NOT_LOADDED @"apiNotLoadded"


@interface aszDlData()

@property (nonatomic,strong) NSString *jdata;

@end
@implementation aszDlData


-(id)initWithJSONDataString:(NSString*)json{
    
    self = [super init];
    if(self){
        
        _jdata=json;
        
    }
    return self;
    
}

-(NSString*)getDataAsJSONString{
    
    return self.jdata;
    
}

@end



@interface aszDlBridge() <UIWebViewDelegate>

@property (nonatomic,assign) BOOL isLoadded;

@property (strong,nonatomic) void (^psuccess)(NSString *);

@property (strong,nonatomic) void (^pfaliure)(NSString *);

@property (strong,nonatomic)  void (^loaddedCallBack)(void);

-(void)precheck;
-(void)fsuccess:(NSString*)msg;
-(void)ffailure:(NSString*)msg;
@end

@implementation aszDlBridge

-(BOOL)didDlLoad{
    return self.isLoadded;
}

-(id)initCallOnLoadded:(void (^)(void))callme {
    
    self = [super initWithDelegate:self];
    
    if(self){
        
        _loaddedCallBack=callme;
        
        _isLoadded = NO;
        
        super.wwwFolderName = @"";
        
        super.startPage =DL_API_URL;
    
        super.view.frame = CGRectMake(65,55,300,300);
    
    }
    return self;
}

-(UIView*) getCDVView{
    return super.view;
}

-(void)setFrame:(CGRect)rect{
    super.view.frame = rect;
}

-(void)fsuccess:(NSString*)msg{
    
    if(self.psuccess)
        self.psuccess(msg);
    
}
-(void)ffailure:(NSString*)msg{
    
    if(self.pfaliure)
        self.pfaliure(msg);
}

-(void)precheck{
  
    if(self.psuccess || self.pfaliure) @throw([NSException exceptionWithName:DL_BRIDGE_TOO_SOON reason:@"previous call still in proggress" userInfo:nil]);
    
    if(!self.isLoadded) @throw([NSException exceptionWithName:DL_BRIDGE_NOT_LOADDED reason:@"api is not loadded yet" userInfo:nil]);
    
    
}

-(void) initPlayer:(aszDlData*)initData OnSuccess: (void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure{
   
    
    [self precheck];
    
    self.psuccess=success;
    self.pfaliure=faliure;
    
    //TODO
   [self.webView stringByEvaluatingJavaScriptFromString:@"TODO"];
    
    
}

-(void) playSequence:(aszDlData*)seqData OnSuccess: (void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure{
    
    
    [self precheck];
    
    self.psuccess=success;
    self.pfaliure=faliure;
    
    //TODO
    [self.webView stringByEvaluatingJavaScriptFromString:@"TODO"];
    
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
        
        self.pfaliure = nil;
        self.psuccess = nil;
        
        // Cancel the location change
        return NO;
    }
    
    // Accept this location change
    return YES;
    
    
}


-(void) webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString* loadded =   [webView stringByEvaluatingJavaScriptFromString: @"var check = function(){ return loadded};   check();" ];
    
    if(![loadded isEqualToString:@"YES"]){
        
        self.isLoadded = YES;
        
        if(!self.isLoadded && self.loaddedCallBack ){
            self.loaddedCallBack();
            //call only once
            self.loaddedCallBack = nil;
        }
    }
//
//        NSMutableString *js=[[NSMutableString alloc]init];
//        
//        [js appendString:@"window.dlhost.initAndPlay("];
//        
//        [js appendString:self.data[0]];
//        
//        [js appendString:@"        ,     "];
//        
//        [js appendString:self.data[1]];
//        
//        [js appendString:@");"];
//        
//        
//        NSMutableString *javaScript =[[NSMutableString alloc]init];
//        [javaScript appendString: @"var loadded = 'YES';   var ondlload =function(){   setTimeout(function(){  "];
//        [javaScript appendString:js  ];
//        [javaScript appendString: @"   },0);    };  "];
//        
//        [webView stringByEvaluatingJavaScriptFromString: javaScript ];
//        
//    }
//    
}

@end
