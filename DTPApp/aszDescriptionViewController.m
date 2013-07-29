//
//  aszDescriptionViewController.m
//  DTPApp
//
//  Created by alex zaikman on 7/21/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszDescriptionViewController.h"
#import <Cordova/CDVViewController.h>


@interface aszDescriptionViewController ()

@end

@implementation aszDescriptionViewController

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dtitle.text=self.t;
    self.overview.text=self.o;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
  
    [self dismissViewControllerAnimated:YES completion:^{ }];
    
}



@end
