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
    

}

-(void) viewWillLayoutSubviews{
    
    self.pageNumber.text = [NSString stringWithFormat:@"Page %d of %d" , self.pageNum , self.pageCount ];
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        
        [self.dlWebView setFrame:CGRectMake(65,55,900,620)];
        
    } else {
        
        [self.dlWebView setFrame:CGRectMake(65,55,630,870)];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
