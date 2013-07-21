//
//  aszDescriptionViewController.h
//  DTPApp
//
//  Created by alex zaikman on 7/21/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface aszDescriptionViewController : UIViewController


@property (strong,nonatomic) NSString *t;
@property (strong,nonatomic) NSString *o;

@property (weak, nonatomic) IBOutlet UILabel *dtitle;

@property (weak, nonatomic) IBOutlet UITextView *overview;

@end
