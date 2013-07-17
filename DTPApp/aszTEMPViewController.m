//
//  aszTEMPViewController.m
//  DTPApp
//
//  Created by alex zaikman on 7/14/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#warning TEMP 

#import "aszTEMPViewController.h"
#import "aszWebBrain.h"
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
    [[aszWebBrain the].brain setFrame:self.web.frame];
    
    [self.view addSubview:  [aszWebBrain the].brain];
    

     NSString *domain = [[NSUserDefaults standardUserDefaults] stringForKey:[domain_def copy]];
    
    [ [aszWebBrain the].brain loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[domain stringByAppendingString:@"/lms"]] ]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
