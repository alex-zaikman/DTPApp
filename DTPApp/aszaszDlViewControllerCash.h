//
//  aszaszDlViewControllerCash.h
//  DTPApp
//
//  Created by alex zaikman on 7/22/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "aszDlViewController.h"

#define cash_size 5

@interface aszaszDlViewControllerCash : NSObject

@property (nonatomic,strong) NSMutableArray *cashedWebViews;

@property (nonatomic,strong) NSArray *hrefs;

-(id)initWithHrefs:(NSArray*)data andCourseId:(NSString*)courseId;


@end
