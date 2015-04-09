
//  FBHandler.m
//  Edureka
//  Copyright (c) 2014 Neeraj Sharma. All rights reserved.


#import "FBHandler.h"

@interface FBHandler()

@property (nonatomic, assign) BOOL isLoggedIn;

@property (copy) FBHandlerLoginSuccessBlock loginSuccessBlock;

@property (copy) FBHandlerLoginFailureBlock loginFailureBlock;

@property (copy) FBHandlerUserInfoSuccessBlock userInfoSuccessBlock;
@end


static FBHandler *sharedFBHandler;

@implementation FBHandler

+ (instancetype)sharedFBHandler {
    
    if(!sharedFBHandler) {
        sharedFBHandler  = [[[self class] alloc] init];
    }
    return sharedFBHandler;
}

- (void)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
    NSArray *permissions =[[NSArray alloc] initWithObjects:
                           @"public_profile",
                           @"user_friends",
                           @"user_location",
                           @"email",
                           @" user_events",
                           @"user_birthday",nil];
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:allowLoginUI
                                  completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                      if (allowLoginUI) {
                                          [self sessionStateChanged:session state:state error:error];
                                      }
                                  }];
}

// This method will handle ALL the session state changes in the app
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error {

    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"fb access token %@",session.accessTokenData.accessToken);
        NSLog(@"Session opened");
        
        if(self.loginSuccessBlock != nil)
            self.loginSuccessBlock(YES);
        
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        NSLog(@"Session closed");
    }
    // Handle errors
    if (error){

        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
         
            if(self.loginFailureBlock != nil)
                self.loginFailureBlock([NSError errorWithDomain:@"" code:3001 userInfo:@{ NSLocalizedDescriptionKey : @"Something went wrong"}]);
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
           
                if(self.loginFailureBlock != nil)
                    self.loginFailureBlock([NSError errorWithDomain:@"" code:3002 userInfo:@{ NSLocalizedDescriptionKey : @"User cancelled login"}]);
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
              
                if(self.loginFailureBlock != nil)
                    self.loginFailureBlock([NSError errorWithDomain:@"" code:3003 userInfo:@{ NSLocalizedDescriptionKey : @"Your current session is no longer valid. Please log in again."}]);
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                if(self.loginFailureBlock != nil)
                    self.loginFailureBlock([NSError errorWithDomain:@"" code:3004 userInfo:@{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]]}]);
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
        //[self userLoggedOut];
    }
}

- (void)loginFacebookWithSuccessBlock:(void (^)(BOOL))successBlock failureBlock:(void (^)(NSError *))failureBlock {
    
    [FBSession.activeSession closeAndClearTokenInformation];
    self.loginSuccessBlock = successBlock;
    self.loginFailureBlock = failureBlock;
    [self openSessionWithAllowLoginUI:YES];
}

- (void)fetchUserInfoWithSuccessBlock:(void (^)(NSDictionary *))successBlock failureBlock:(void (^)(NSError *))failureBlock {
    
    self.userInfoSuccessBlock = successBlock;
    self.loginFailureBlock = failureBlock;
    [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
        if(!error) {
            
            if(self.userInfoSuccessBlock != nil)
                self.userInfoSuccessBlock (result);
        }
        else {
            
            if(self.loginFailureBlock != nil)
                self.loginFailureBlock([NSError errorWithDomain:@"" code:3005 userInfo:@{ NSLocalizedDescriptionKey : @"Unable to process your request at this time. Please try again later!"}]);
        }
    }];
}
@end
