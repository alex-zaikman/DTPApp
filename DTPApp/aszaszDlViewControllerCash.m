//
//  aszaszDlViewControllerCash.m
//  DTPApp
//
//  Created by alex zaikman on 7/22/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszaszDlViewControllerCash.h"
#import "aszDls.h"
#import "aszUtils.h"


@implementation aszaszDlViewControllerCash



-(id)initWithHrefs:(NSArray*)data andCourseId:(NSString*)courseId {
    self= [super init];
    if(self){

        _hrefs = data;
        
    }
    return self;
}


-(UIWebView*) viewForIndex:(int)index{
    

    if(!self.cashedWebViews){
        self.cashedWebViews = [[NSMutableArray alloc]initWithCapacity:cash_size];
        
         for(int i=0 ; i<cash_size ;i++){
             
             UIWebView *view = [[UIWebView alloc]init];
             
        //     aszDlWebViewDelegate *delegate =[[aszDlWebViewDelegate alloc]initWtihData:@[  ] ];
             
          //   dlview.wdelegate =  delegate;
             
             
             
             [self.cashedWebViews addObject:view];
             
         }
        
    }
    
    
}

/*
 
 aszDls* dls = [[aszDls alloc]initWithHrefs:data  forCourseId:courseId];
 
 
 for(int i=0 ; i<size ;i++){
 
 
 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[[NSBundle mainBundle].infoDictionary objectForKey:@"MainStoryboard"] bundle:[NSBundle mainBundle]];
 
 
 aszDlViewController *dlview= [storyboard instantiateViewControllerWithIdentifier:@"aszDlViewController"];
 
 aszDlWebViewDelegate *delegate =[[aszDlWebViewDelegate alloc]initWtihData:@[((aszDl*)dls.dataArray[0]).iniData   ,  ((aszDl*)dls.dataArray[0]).playData  ] ];
 
 dlview.wdelegate =  delegate;
 
 NSString *urlAddress = @"http://cto.timetoknow.com/cms/player/dl/index2.html";
 
 NSURLRequest *request2 = [aszUtils requestWithUrl:urlAddress usingMethod:@"GET" withUrlParams:nil andBodyData:nil];
 
 dlview.request = request2;
 

 */

@end
