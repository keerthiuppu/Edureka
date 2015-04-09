//
//  LinkedInHandler.m
//  Edureka
//
//  Created by Neeraj Sharma on 07/04/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "LinkedInHandler.h"
#import "LIALinkedInHttpClient.h"
#import "LIALinkedInApplication.h"

#define KEY_LINKEDIN_API                 @"78zzzo8ko6pv2b"
#define KEY_SECRET              @"f23Tdn4TRYhcWrk6"
#define KEY_OAUTH_USER_TOKEN    @"f0de051f-7862-43a5-807d-c0b303d73161"
#define KEY_OAUTH_USER_SECRET   @"1fe3da69-60b4-433d-aaa5-e87b8fcccb9c"


static LinkedInHandler *sharedLinkedInHandler;

@implementation LinkedInHandler

+ (instancetype)sharedLinkedInHandler {
    
    if(!sharedLinkedInHandler) {
        sharedLinkedInHandler  = [[[self class] alloc] init];
    }
    return sharedLinkedInHandler;
}


- (LIALinkedInHttpClient *)client {
    LIALinkedInApplication *application = [LIALinkedInApplication applicationWithRedirectURL:@"http://www.edureka.co"
                                                                                    clientId:KEY_LINKEDIN_API
                                                                                clientSecret:KEY_SECRET
                                                                                       state:APP_NAME
                                                                               grantedAccess:@[@"r_fullprofile",@"r_network",@"r_emailaddress",@"r_contactinfo",@"rw_nus"]];
    return [LIALinkedInHttpClient clientForApplication:application presentingViewController:[APP_DELEGATE window].rootViewController];
}

- (void)loginLinkedInForAppWithParams:(NSMutableDictionary *)params WithCompletionBlock:(void (^)(NSDictionary *dict, NSError *error))completionBlock
{
    [self.client getAuthorizationCode:^(NSString *code) {

        [self.client getAccessToken:code success:^(NSDictionary *accessTokenData) {
            NSString *accessToken = [accessTokenData objectForKey:@"access_token"];

            [self.client GET:[NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~:(id,first-name,last-name,maiden-name,email-address)?oauth2_access_token=%@&format=json", accessToken] parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *result) {
                
                NSLog(@"current user %@", result);
                if (result) {
                    if(completionBlock) completionBlock(result,nil);
                    
                }
                
            }        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //kShowAlert(@"Error", error.localizedDescription, nil);
                NSLog(@"failed to fetch current user %@", error);
            }];
            
        }                   failure:^(NSError *error) {
           
            //kShowAlert(@"Error", error.localizedDescription, nil);
            NSLog(@"Quering accessToken failed %@", error);
        }];
        
    }                      cancel:^{

        NSLog(@"Authorization was cancelled by user");
    }                     failure:^(NSError *error) {
        NSLog(@"Authorization failed %@", error);
//        kShowAlert(@"Error", error.localizedDescription, nil);
    }];
}


@end
