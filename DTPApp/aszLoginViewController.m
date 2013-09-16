//
//  aszLoginViewController.m
//  DTPApp
//
//  Created by alex zaikman on 7/8/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "aszLoginViewController.h"
#import "aszT2KApi.h"
#import "aszUtils.h"
#import "aszApiBridge.h"


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

    if(!logged){
        [aszApiBridge the];
        
        
        
        
//        [aszApiBridge the].cdvbrain = [CDVViewController new];
//        
//        
//    //    [aszApiBridge the].cdvbrain.customDelegate= self;
//         [aszApiBridge the].cdvbrain.wwwFolderName = @"";
//        
//         [aszApiBridge the].cdvbrain.startPage = @"http://cto.timetoknow.com/lms/js/libs/t2k/t2k.html";
//        
//         [aszApiBridge the].cdvbrain.view.frame =CGRectMake(0,0, 900, 900);
//        
//          [self.view addSubview:[aszApiBridge the].cdvbrain.view];   
//        
//        [self.view setNeedsDisplay];
        
               
        
        
    }

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
            
            
        }else{
            //remouve default user and password on login success
            [defaults setObject:@"user name" forKey:[username_def copy]];
            [defaults setObject:@"password" forKey:[password_def  copy]];
            
           
        }
        
        [defaults synchronize];
        
        
        //use msg
        self.outputView.text=@"Logging... \n please wait.";
        [aszT2KApi loadOnSuccess:^(NSString *msg) {
            
            [aszT2KApi initOnSuccess:^(NSString *msg) {
                
                [aszT2KApi logInWithUser:self.userName.text  andPassword:self.password.text OnSuccess:^(NSString *msg) {
                    
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
                    
                } OnFaliure:^(NSString *error) {
                    
                }];
                
                
                

                
            } OnFaliure:^(NSString *err) {
                
            }];
            
            
        } OnFaliure:^(NSString *err) {
            
        }];
        
              
        
    }else{
      
        [aszT2KApi logOutOnSuccess: ^(NSString *msg){
    
                    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
                    logged = NO;
        
                    self.loginButton.enabled=YES;
                    [self.progressBar stopAnimating];
        } OnFaliure:^(NSString *err) {
            
        }];
        
    }
    
}

@end
