//
//  aszDlBridge.m
//  DTPApp
//
//  Created by alex zaikman on 8/4/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszDlBridge.h"
#import "aszUtils.h"
#define DL_API_URL   @"http://cto.timetoknow.com/cms/player/dl/index2.html"

#define DL_BRIDGE_TOO_SOON @"prematureApiCall"
#define DL_BRIDGE_NOT_LOADDED @"apiNotLoadded"


@interface aszDlBridge() <UIWebViewDelegate>

@property (nonatomic,assign) BOOL isLoadded;

@property (nonatomic,assign) BOOL initandplay;

@property (nonatomic,strong) NSString *initializeData;
@property (nonatomic,strong) NSString *playData;

@property (strong,nonatomic) void (^psuccess)(NSString *);

@property (strong,nonatomic) void (^pfaliure)(NSString *);

@property (strong,nonatomic)  void (^loaddedCallBack)(void);

-(void)precheck;
-(void)fsuccess:(NSString*)msg;
-(void)ffailure:(NSString*)msg;

-(NSString*)createCommandForAction:(NSString*)action withData:(NSString*)data;

@end

@implementation aszDlBridge



-(BOOL)didDlLoad{
    return self.isLoadded;
}

-(id)initInit:(NSString*)initdata {
    
    self = [super initWithDelegate:self];
    
    if(self){
        
        _initializeData=initdata;
        _playData=nil;
        
        _initandplay=YES;
        
        _isLoadded = NO;
        
        super.wwwFolderName = @"";
        
        super.startPage =DL_API_URL;
        
        super.view.frame = CGRectMake(65,55,300,300);
        
    }
    return self;
}


-(id)initInit:(NSString*)initdata andPlay:(NSString*)playdata{
    
    self = [super initWithDelegate:self];
    
    if(self){
        
        _initializeData=initdata;
        _playData=playdata;

        _initandplay=YES;
        
        _isLoadded = NO;
        
        super.wwwFolderName = @"";
        
        super.startPage =DL_API_URL;
        
        super.view.frame = CGRectMake(65,55,300,300);
        
    }
    return self;
    
}

-(id)initCallOnLoadded:(void (^)(void))callme {
    
    self = [super initWithDelegate:self];
    
    if(self){
        
        _initializeData=nil;
        _playData=nil;
        
        _initandplay=NO;
        
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

-(NSString*)createCommandForAction:(NSString*)action withData:(NSString*)data{
   
    NSMutableString *command = [[NSMutableString alloc]init];
    
    [command appendString:@"dlhost.player.api('"];
    [command appendString:action];
    [command appendString:@"', "];
    [command appendString:data];
    [command appendString:@", function(res){ callback(res,'fsuccess:' ); },function(res){ callback(res,'ffailure:' ); } );"];
 
    return command;
}


-(void)initPlayer:(NSString*)initData OnSuccess: (void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure{

    
    [self precheck];
    
    self.psuccess=success;
    self.pfaliure=faliure;
    
       
   [self.webView stringByEvaluatingJavaScriptFromString: [self createCommandForAction:@"init" withData:initData]  ];
    
    
}

-(void)playSequence:(NSString*)seqData OnSuccess: (void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure{

    
    [self precheck];
    
    self.psuccess=success;
    self.pfaliure=faliure;
    
    [self.webView stringByEvaluatingJavaScriptFromString: [self createCommandForAction:@"playSequence" withData:seqData]  ];
    
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
    
    if(!self.isLoadded ){
        NSString* loadded =   [webView stringByEvaluatingJavaScriptFromString: @"var check = function(){ return loadded};   check();" ];
    
        if([loadded isEqualToString:@"YES"]){
                
            if(self.loaddedCallBack ){
                self.loaddedCallBack();
                //call only once
                self.loaddedCallBack = nil;
            }
        
            if(self.initandplay){
            
                [self initPlayer:self.initializeData OnSuccess:^(NSString *msg) {
                    if(self.playData){
                        [self playSequence:self.playData OnSuccess:^(NSString *msg) {
                        //do nothing
                        } OnFaliure:^(NSString *err) {
                            @throw([NSException exceptionWithName:@"DL_BRIDGE_PLAY_FAILED" reason:err userInfo:nil]);
                        }];
                    }
                
                } OnFaliure:^(NSString *err) {
                    @throw([NSException exceptionWithName:@"DL_BRIDGE_LOAD_FAILED" reason:err userInfo:nil]);
                }];
            }
           
            self.isLoadded = YES;
        }
    }
    
    
    //....
    
    
}

@end
