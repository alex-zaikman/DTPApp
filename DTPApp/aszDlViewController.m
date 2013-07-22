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



-(id) initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if(self){

    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.delegate = self.wdelegate;
    
    self.pageNumber.text = [NSString stringWithFormat:@"Page %d of %d" , self.pageNum , self.pageCount ];

    [self.webView loadRequest:self.request];
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
