//
//  EDOperationHandler.m
//  Edureka
//
//  Created by Neeraj Sharma on 04/04/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "EDOperationHandler.h"
#import "CommonBL.h"
#import "UserBL.h"

@implementation EDOperationHandler

static EDOperationHandler* sharedObj = nil;

+(EDOperationHandler*)sharedInstance
{
    if(sharedObj==nil)
    {
        sharedObj=[[EDOperationHandler alloc]init];
    }
    return sharedObj;
}

#pragma mark - Auth API.
- (void)getAuthTokenForApp:(NSMutableDictionary*)params WithCompletionBlock:(void (^)(NSMutableDictionary *, NSError *))completionBlock {
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",BASE_URL,AUTH_URL];
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"application/json", nil]];
    
    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(responseObject)
        {
            NSMutableDictionary* dict = (NSMutableDictionary*) responseObject;
            if([[[dict objectForKey:@"data"] objectForKey:@"status"] intValue]==200)
            {
                [[CommonBL sharedInstance] parseAppAuthData:[dict objectForKey:@"data"]];
                if(completionBlock) completionBlock(responseObject,nil);
            }
            else{
                if([[dict objectForKey:@"data"] objectForKey:@"message"])
                    [[CommonBL sharedInstance] showErrorAlertWithMessage:[[dict objectForKey:@"data"] objectForKey:@"message"]];
            }
        }
        else {
            if(completionBlock) completionBlock(nil,[NSError errorWithDomain:@"" code:-2000 userInfo:nil]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(completionBlock) completionBlock(nil,error);
    }];
}

#pragma mark - User Related Webservice
- (void)loginUserWithParams:(NSMutableDictionary*)params WithCompletionBlock:(void (^)(NSMutableDictionary *, NSError *))completionBlock {
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",BASE_URL,LOGIN_URL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:KEY_TOKEN_ID] forHTTPHeaderField:@"TOKEN"];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"application/json", nil]];

    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(responseObject)
        {
            NSMutableDictionary* dict = (NSMutableDictionary*) responseObject;
            if([[[dict objectForKey:@"data"] objectForKey:@"status"] intValue]==200)
            {
                [[UserBL sharedInstance] parseUserData:[[dict objectForKey:@"data"] objectForKey:@"userData"]];
                if(completionBlock) completionBlock(responseObject,nil);
            }
            else{
                [APP_DELEGATE hideLoadingBar];

                if([[dict objectForKey:@"data"] objectForKey:@"message"])
                    [[CommonBL sharedInstance] showErrorAlertWithMessage:[[dict objectForKey:@"data"] objectForKey:@"message"]];
            }
        }
        else {
            [APP_DELEGATE hideLoadingBar];
            if(completionBlock) completionBlock(nil,[NSError errorWithDomain:@"" code:-2000 userInfo:nil]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [APP_DELEGATE hideLoadingBar];
        if(completionBlock) completionBlock(nil,error);
    }];
}


- (void)registerUserWithParams:(NSMutableDictionary*)params WithCompletionBlock:(void (^)(NSMutableDictionary *, NSError *))completionBlock {
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",BASE_URL,REGISTER_URL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:KEY_TOKEN_ID] forHTTPHeaderField:@"TOKEN"];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"application/json", nil]];
    
    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(responseObject)
        {
            NSMutableDictionary* dict = (NSMutableDictionary*) responseObject;
            if([[[dict objectForKey:@"data"] objectForKey:@"status"] intValue]==200)
            {
                [[UserBL sharedInstance] parseUserData:[[dict objectForKey:@"data"] objectForKey:@"userData"]];
                if(completionBlock) completionBlock(responseObject,nil);
            }
            else{
                [APP_DELEGATE hideLoadingBar];
                
                if([[dict objectForKey:@"data"] objectForKey:@"message"])
                    [[CommonBL sharedInstance] showErrorAlertWithMessage:[[dict objectForKey:@"data"] objectForKey:@"message"]];
            }
        }
        else {
            [APP_DELEGATE hideLoadingBar];
            if(completionBlock) completionBlock(nil,[NSError errorWithDomain:@"" code:-2000 userInfo:nil]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [APP_DELEGATE hideLoadingBar];
        if(completionBlock) completionBlock(nil,error);
    }];
}

- (void)logoutUserWithParams:(NSMutableDictionary*)params WithCompletionBlock:(void (^)(NSMutableDictionary *, NSError *))completionBlock {
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",BASE_URL,LOGOUT_URL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:KEY_TOKEN_ID] forHTTPHeaderField:@"TOKEN"];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_SESSION_ID] forHTTPHeaderField:@"SID"];

    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"application/json", nil]];
    
    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(responseObject)
        {
            NSMutableDictionary* dict = (NSMutableDictionary*) responseObject;
            if([[[dict objectForKey:@"data"] objectForKey:@"status"] intValue]==200)
            {
                [[UserBL sharedInstance] parseUserData:[[dict objectForKey:@"data"] objectForKey:@"userData"]];
                if(completionBlock) completionBlock(responseObject,nil);
            }
            else{
                [APP_DELEGATE hideLoadingBar];
                
                if([[dict objectForKey:@"data"] objectForKey:@"message"])
                    [[CommonBL sharedInstance] showErrorAlertWithMessage:[[dict objectForKey:@"data"] objectForKey:@"message"]];
            }
        }
        else {
            [APP_DELEGATE hideLoadingBar];
            if(completionBlock) completionBlock(nil,[NSError errorWithDomain:@"" code:-2000 userInfo:nil]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [APP_DELEGATE hideLoadingBar];
        if(completionBlock) completionBlock(nil,error);
    }];
}


- (void)forgotPasswordWithParams:(NSMutableDictionary*)params WithCompletionBlock:(void (^)(NSMutableDictionary *, NSError *))completionBlock {
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",BASE_URL,FORGOT_PASSWORD_URL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:KEY_TOKEN_ID] forHTTPHeaderField:@"TOKEN"];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"application/json", nil]];
    
    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(responseObject)
        {
            NSMutableDictionary* dict = (NSMutableDictionary*) responseObject;
            if([[[dict objectForKey:@"data"] objectForKey:@"status"] intValue]==200)
            {
               // [[UserBL sharedInstance] parseUserData:[[dict objectForKey:@"data"] objectForKey:@"userData"]];
                if(completionBlock) completionBlock(responseObject,nil);
            }
            else{
                [APP_DELEGATE hideLoadingBar];
                
                if([[dict objectForKey:@"data"] objectForKey:@"message"])
                    [[CommonBL sharedInstance] showErrorAlertWithMessage:[[dict objectForKey:@"data"] objectForKey:@"message"]];
            }
        }
        else {
            [APP_DELEGATE hideLoadingBar];
            if(completionBlock) completionBlock(nil,[NSError errorWithDomain:@"" code:-2000 userInfo:nil]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [APP_DELEGATE hideLoadingBar];
        if(completionBlock) completionBlock(nil,error);
    }];
}

#pragma mark - Category Listing API
- (void)getCategoriesWithParams:(NSMutableDictionary*)params WithCompletionBlock:(void (^)(NSMutableArray *, NSError *))completionBlock {
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",BASE_URL,CATEGORIES_URL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:KEY_TOKEN_ID] forHTTPHeaderField:@"TOKEN"];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:KEY_SESSION_ID] forHTTPHeaderField:@"SID"];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"application/json", nil]];
    
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(responseObject)
        {
            NSMutableDictionary* dict = (NSMutableDictionary*) responseObject;
            if([[[dict objectForKey:@"data"] objectForKey:@"status"] intValue]==200)
            {
                // [[UserBL sharedInstance] parseUserData:[[dict objectForKey:@"data"] objectForKey:@"userData"]];
                if(completionBlock) completionBlock(responseObject,nil);
            }
            else{
                [APP_DELEGATE hideLoadingBar];
                
                if([[dict objectForKey:@"data"] objectForKey:@"message"])
                    [[CommonBL sharedInstance] showErrorAlertWithMessage:[[dict objectForKey:@"data"] objectForKey:@"message"]];
            }
        }
        else {
            [APP_DELEGATE hideLoadingBar];
            if(completionBlock) completionBlock(nil,[NSError errorWithDomain:@"" code:-2000 userInfo:nil]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [APP_DELEGATE hideLoadingBar];
        if(completionBlock) completionBlock(nil,error);
    }];
}


@end
