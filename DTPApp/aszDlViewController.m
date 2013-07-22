//
//  aszDlViewController.m
//  DTPApp
//
//  Created by alex zaikman on 7/11/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszDlViewController.h"

@interface aszDlViewController ()



@property (nonatomic,strong) aszDlWebViewDelegate *webViewDelegate;

@property (weak, nonatomic) IBOutlet UILabel *pageNumber;



@end




@implementation aszDlViewController







- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dlWebView.delegate = self.wdelegate;
    
    self.pageNumber.text = [NSString stringWithFormat:@"Page %d of %d" , self.pageNum , self.pageCount ];

    [self.dlWebView loadRequest:self.request];
    
    [self.view addSubview:self.dlWebView];
    
    
}

-(void) viewWillLayoutSubviews{
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        
        [self.dlWebView setFrame:CGRectMake(60,50,900,638)];
        
    } else {
        
        [self.dlWebView setFrame:CGRectMake(60,50,645,900)];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
