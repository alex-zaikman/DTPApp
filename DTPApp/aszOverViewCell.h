//
//  aszOverViewCell.h
//  DTPApp
//
//  Created by alex zaikman on 7/9/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "aszRowNode.h"

@interface aszOverViewCell : UITableViewCell

@property (nonatomic,assign) BOOL expanded;
@property (nonatomic,assign) int level;
@property (nonatomic,strong) NSString *value;
@property (nonatomic,weak) aszRowNode *selfNode;

-(void)appplyState;
-(void)toggle;

@end
