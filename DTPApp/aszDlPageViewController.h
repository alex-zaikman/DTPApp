//
//  aszDlPageViewController.h
//  DTPApp
//
//  Created by alex zaikman on 8/7/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface aszDlPageViewController : UIPageViewController <UIPageViewControllerDataSource , UIPageViewControllerDelegate>

@property (nonatomic,strong) NSString *courseId;
@property (nonatomic,strong) NSString *lessonId;
@property (nonatomic,strong) NSString *ccid;


@end

@interface naszSeq :NSObject
@property (nonatomic,strong) NSString *stitle;
@property (nonatomic,strong) NSString *contentHref;
@property (nonatomic,strong) NSString *thumbnailHref;
@end


@interface naszLo :NSObject
@property (nonatomic,strong) NSString *pedagogicalLoType;
@property (nonatomic,strong) NSMutableArray *seqs;
@end

