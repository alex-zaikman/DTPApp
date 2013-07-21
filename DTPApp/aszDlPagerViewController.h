//
//  aszDlViewController.h
//  DTPApp
//
//  Created by alex zaikman on 7/11/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface aszDlPagerViewController : UIPageViewController <UIPageViewControllerDataSource , UIPageViewControllerDelegate>

@property (nonatomic,strong) NSDictionary *rawData;

@property (nonatomic,strong) NSString *courseId;
@property (nonatomic,strong) NSString *lessonId;


@end
