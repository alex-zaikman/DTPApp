//
//  aszLoginViewController.m
//  DTPApp
//
//  Created by alex zaikman on 7/8/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszLoginViewController.h"
#import "aszDTPApi.h"
#import "aszUtils.h"
#import "aszWebBrain.h"


@interface aszLoginViewController ()

@end

@implementation aszLoginViewController

- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateParent" object:nil];
        
    }];
    
}

static BOOL logged = NO;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSURLRequest *request =[[NSURLRequest alloc]initWithURL:[[NSURL alloc]initWithString:API_URL]];
    [aszWebBrain the].brain.delegate=[aszWebBrain the];
    [[aszWebBrain the].brain loadRequest:request];

    
	// Do any additional setup after loading the view.
    
    if(logged)
        [self.loginButton setTitle:@"Logout" forState:UIControlStateNormal];
    
    
    
    //get defaults
    NSString *user = [[NSUserDefaults standardUserDefaults] stringForKey:[username_def copy]];
    NSString *pass = [[NSUserDefaults standardUserDefaults] stringForKey:[password_def copy]];
    
    self.userName.text = user?user:@"user name";
    self.password.text = pass?pass:@"password";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)login:(id)sender {
    
    self.loginButton.enabled=NO;
    
    
    self.progressBar.hidden = NO;
    [self.progressBar startAnimating];
    
    
    if(! logged)
    {
        //store user and password
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if(self.remember.isOn){
            //store default user and password on login success
            [defaults setObject:self.userName.text forKey:[username_def copy]];
            [defaults setObject:self.password.text forKey:[password_def  copy]];
            
            [aszUtils LOG:@"defs - set"];
        }else{
            //remouve default user and password on login success
            [defaults setObject:@"user name" forKey:[username_def copy]];
            [defaults setObject:@"password" forKey:[password_def  copy]];
            
            [aszUtils LOG:@"defs - removed"];
        }
        
        [defaults synchronize];
        
        
        //use msg
        self.outputView.text=@"Logging... \n please wait.";

        [aszDTPApi logInWithUser:@"" andPassword:@"" callBack:^(NSString *msg) {
            
          //  NSDictionary *dic =  [aszUtils jsonToDictionarry:msg];
            
                
               // NSDictionary *dic =  [aszUtils jsonToDictionarry:msg];
                
                self.outputView.text=@"You are logged in.";
                
                [self.loginButton setTitle:@"Logout" forState:UIControlStateNormal];
                
                logged = YES;
                
                
                self.loginButton.enabled=YES;
                
                [self.progressBar stopAnimating];
                
                [self dismissViewControllerAnimated:YES completion:^{
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateParent" object:nil];
            }];
            
        }];
        
         
        
        
        
    }else{
      
        [aszDTPApi logOutCall:^(NSString *msg){
    
                    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
                    logged = NO;
        
                    self.loginButton.enabled=YES;
                    [self.progressBar stopAnimating];
        }];
        
    }
    
}

@end
