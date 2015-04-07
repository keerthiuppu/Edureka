//
//  FBHandler.h
//  Edureka
//  Copyright (c) 2014 Neeraj Sharma. All rights reserved.


#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

typedef void(^FBHandlerLoginSuccessBlock)(BOOL success);
typedef void (^FBHandlerUserInfoSuccessBlock)(NSDictionary *userInfo);
typedef void(^FBHandlerLoginFailureBlock)(NSError *error);

@interface FBHandler : NSObject

/** This method returns shared Instance of FBHandler Class
 */

+ (instancetype)sharedFBHandler;

- (void)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;

- (void)loginFacebookWithSuccessBlock:(void(^)(BOOL success))successBlock
               failureBlock:(void(^)(NSError * error))failureBlock;

- (void)fetchUserInfoWithSuccessBlock:(void(^)(NSDictionary *userInfo))successBlock
                         failureBlock:(void(^)(NSError * error))failureBlock;
@end
