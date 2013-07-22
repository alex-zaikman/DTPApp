//
//  aszDlViewController.h
//  DTPApp
//
//  Created by alex zaikman on 7/11/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "aszDls.h"

@interface aszSeq :NSObject
@property (nonatomic,strong) NSString *stitle;
@property (nonatomic,strong) NSString *contentHref;
@property (nonatomic,strong) NSString *thumbnailHref;
@end


@interface aszLo :NSObject
@property (nonatomic,strong) NSString *pedagogicalLoType;
@property (nonatomic,strong) NSMutableArray *seqs;
@end



@interface aszDlPagerViewController : UIPageViewController <UIPageViewControllerDataSource , UIPageViewControllerDelegate>

@property (nonatomic,strong) NSDictionary *rawData;

@property (nonatomic,strong) NSString *courseId;
@property (nonatomic,strong) NSString *lessonId;

@property (nonatomic,strong) NSMutableArray *los;

-(void) moveToPage:(NSNotification*)notification;



@property (nonatomic,strong)  aszDls *dls;
@property (nonatomic,strong)  NSMutableArray *delegates;
@property (nonatomic,strong)  NSMutableArray *dlWebviews;

-(UIWebView*)dlWebViewForIndex:(int)index;

@end


