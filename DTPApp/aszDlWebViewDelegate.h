//
//  aszDlWebViewDelegate.h
//  DTPApp
//
//  Created by alex zaikman on 7/11/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface aszDlWebViewDelegate : NSObject <UIWebViewDelegate>

@property (nonatomic,strong) NSArray *data;

-(id)initWtihData:(NSArray*)data;

@end
