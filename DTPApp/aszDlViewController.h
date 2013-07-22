//
//  aszDlViewController.h
//  DTPApp
//
//  Created by alex zaikman on 7/11/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "aszDlWebViewDelegate.h"


@interface aszDlViewController : UIViewController


@property (nonatomic,assign) int pageNum;
@property (nonatomic,assign) int pageCount;

@property (nonatomic,strong) NSArray *dlData;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic,strong) NSURLRequest *request;
@property (nonatomic,strong)  id<UIWebViewDelegate> wdelegate;


@end
