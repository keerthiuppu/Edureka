//
//  EDOperationHandler.h
//  Edureka
//
//  Created by Neeraj Sharma on 04/04/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDOperationHandler : NSObject
+(EDOperationHandler*)sharedInstance;

- (void)getAuthTokenForApp:(NSMutableDictionary *)params WithCompletionBlock:(void (^)(NSMutableDictionary *dict, NSError *error))completionBlock;

- (void)loginUserWithParams:(NSMutableDictionary*)params WithCompletionBlock:(void (^)(NSMutableDictionary *dict, NSError *error))completionBlock;

- (void)registerUserWithParams:(NSMutableDictionary*)params WithCompletionBlock:(void (^)(NSMutableDictionary *dict, NSError *error))completionBlock;

- (void)logoutUserWithParams:(NSMutableDictionary*)params WithCompletionBlock:(void (^)(NSMutableDictionary *dict, NSError *error))completionBlock;

- (void)forgotPasswordWithParams:(NSMutableDictionary*)params WithCompletionBlock:(void (^)(NSMutableDictionary *dict, NSError *error))completionBlock;

- (void)getCategoriesWithParams:(NSMutableDictionary*)params WithCompletionBlock:(void (^)(NSMutableArray *categoryArray, NSError *error))completionBlock;

- (void)getHomeCoursesWithParams:(NSMutableDictionary*)params WithCompletionBlock:(void (^)(NSMutableArray *courseArray, NSError *error))completionBlock;


@end
