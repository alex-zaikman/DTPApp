//
//  aszDlWebViewDelegate.m
//  DTPApp
//
//  Created by alex zaikman on 7/11/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszDlWebViewDelegate.h"



@implementation aszDlWebViewDelegate



-(id)initWtihData:(NSArray*)data{
    self=[super init];
    if(self){
        
        _data=data;
        
    }return self;
}



-(void) webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString* loadded =   [webView stringByEvaluatingJavaScriptFromString: @"var check = function(){ return loadded};   check();" ];
    
    if(![loadded isEqualToString:@"YES"]){
    
    NSMutableString *js=[[NSMutableString alloc]init];
    
    [js appendString:@"window.dlhost.initAndPlay("];
    
    [js appendString:self.data[0]];
    
    [js appendString:@"        ,     "];
    
    [js appendString:self.data[1]];
    
    [js appendString:@");"];
    
    //NSLog(@"%@",js);
    
    
    NSMutableString *javaScript =[[NSMutableString alloc]init];
    [javaScript appendString: @"var loadded = 'YES';   var boo =function(){   setTimeout(function(){  "];
    [javaScript appendString:js  ];
    [javaScript appendString: @"   },0);    };  "];
    
    [webView stringByEvaluatingJavaScriptFromString: javaScript ];
  
    }
    
}


@end
