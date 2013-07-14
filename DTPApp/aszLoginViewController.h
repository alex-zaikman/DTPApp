//
//  aszLoginViewController.h
//  DTPApp
//
//  Created by alex zaikman on 7/8/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface aszLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progressBar;

@property (weak, nonatomic) IBOutlet UITextView *outputView;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UISwitch *remember;

@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (weak, nonatomic) IBOutlet UITextField *password;

@end
