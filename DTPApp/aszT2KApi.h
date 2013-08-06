//
//  aszT2KApi.h
//  DTPApp
//
//  Created by alex zaikman on 8/4/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#ifndef aszT2KApi_g4gh35ghu35bf3ug53ug3ubg3u5vbn111
#define aszT2KApi_g4gh35ghu35bf3ug53ug3ubg3u5vbn111

#import <Foundation/Foundation.h>

@interface aszT2KApi : NSObject

+(void) loadOnSuccess:(void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure;

+(void) initOnSuccess:(void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure;

+(void) logInWithUser:(NSString*)user andPassword:(NSString*)pass OnSuccess:(void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure;

+(void) logOutOnSuccess:(void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure;;

+(void) getStudyClassesOnSuccess:(void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure;

+(void) getCourse:(NSString*)cid  OnSuccess:(void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure;

+(void) getLessonContent:(NSString*)courseId forLesson:(NSString*)lessonId  OnSuccess:(void (^)(NSString *))success  OnFaliure:(void (^)(NSString *))faliure;


@end

#endif
