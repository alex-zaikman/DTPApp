//
//  aszDTPApi.h
//  DTPApp
//
//  Created by alex zaikman on 7/11/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface aszDTPApi : NSObject <UIWebViewDelegate>

+(void) logInWithUser:(NSString*)user andPassword:(NSString*)pass callBack:(void (^)(NSString *))callme;

+(void) logOutCall:(void (^)(NSString *))callme ;

+(void) getStudyClassesCall:(void (^)(NSString *))callme;

+(void) getCourse:(NSString*)cid Call:(void (^)(NSString *))callme;

+(void) getLessonContent:(NSString*)courseId forLesson:(NSString*)lessonId Call:(void (^)(NSString *))callme;

@end
