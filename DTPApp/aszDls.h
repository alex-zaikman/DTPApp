//
//  aszDls.h
//  DTPApp
//
//  Created by alex zaikman on 7/22/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface aszDl : NSObject



@property (nonatomic,strong) NSString *iniData;

@property (nonatomic,strong) NSString *playData;

@end


@interface aszDls : NSObject

@property (nonatomic,strong) NSMutableArray/* <aszDl*> */ *dataArray;

//@property (nonatomic,strong) NSMutableArray *webViews;

-(id) initWithHrefs:(NSArray *)refs forCourseId:(NSString*)cid;

@end
