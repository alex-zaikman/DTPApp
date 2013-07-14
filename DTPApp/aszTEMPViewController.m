//
//  aszTEMPViewController.m
//  DTPApp
//
//  Created by alex zaikman on 7/14/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszTEMPViewController.h"

@interface aszTEMPViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *web;

@end

@implementation aszTEMPViewController

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
	// Do any additional setup after loading the view.
    
    [self.web loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://cto.timetoknow.com/lms"] ]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
