//
//  aszSequenseViewController.h
//  DTPApp
//
//  Created by alex zaikman on 7/21/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "aszDlPagerViewController.h"


@interface aszSequenseViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *los;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
