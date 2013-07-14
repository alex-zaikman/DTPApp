//
//  aszOverViewCell.m
//  DTPApp
//
//  Created by alex zaikman on 7/9/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#define IMG_HEIGHT_WIDTH 40
#define CELL_HEIGHT 80
#define SCREEN_WIDTH 320
#define LEVEL_INDENT 52
#define YOFFSET 22
#define XOFFSET 6

#import "aszOverViewCell.h"

@implementation aszOverViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    CGRect contentRect = self.contentView.bounds;
	
    if (!self.editing) {
		
		// get the X pixel spot
        CGFloat boundsX = contentRect.origin.x;
		CGRect frame;
		
		frame = CGRectMake((boundsX + self.level + 1) * LEVEL_INDENT,
						   0,
						   SCREEN_WIDTH - (self.level * LEVEL_INDENT),
						   CELL_HEIGHT);
		self.textLabel.frame = frame;
		
		CGRect imgFrame;
		imgFrame = CGRectMake(((boundsX + self.level + 1) * LEVEL_INDENT) - (IMG_HEIGHT_WIDTH + XOFFSET),
							  YOFFSET,
							  IMG_HEIGHT_WIDTH,
							  IMG_HEIGHT_WIDTH);
		self.imageView.frame = imgFrame;
	}
    
}

-(void)toggle{
    
    [self.selfNode toggle];
    
    self.expanded = !self.expanded;
    
    UITableView *parentTable = (UITableView *)self.superview;
    
    [parentTable reloadData];
    
}

-(void)appplyState{
    
    
    
    self.textLabel.text=self.value;

    if([self.selfNode isLeaf])
    {
        self.imageView.image = [UIImage imageNamed:@"CircleNoArrow_sml"];

    }
    else
        self.imageView.image = [UIImage imageNamed:self.expanded ?  @"CircleArrowDown_sml" : @"CircleArrowRight_sml"];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggle)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    
    [self.imageView addGestureRecognizer:singleTap];
    [self.imageView setUserInteractionEnabled:YES];
    
   
    
  }



@end
