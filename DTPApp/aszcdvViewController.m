//
//  aszcdvViewController.m
//  DTPApp
//
//  Created by alex zaikman on 7/25/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszcdvViewController.h"
#import "CDVViewController.h"
#import "CDVWebViewDelegate.h"

@interface aszcdvViewController ()

@end

@implementation aszcdvViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    static CDVViewController *dlCDVWebView;
    
    dlCDVWebView = [CDVViewController new];
    
    dlCDVWebView.wwwFolderName = @"";
    dlCDVWebView.startPage = @"http://cnn.com";
    
    
    static CDVWebViewDelegate *tt ;
    tt= [CDVWebViewDelegate new];
    
    dlCDVWebView.webView.delegate = tt;
    
    dlCDVWebView.view.frame =  CGRectMake(100, 100, 620, 780);
    [self.view addSubview:dlCDVWebView.view];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
