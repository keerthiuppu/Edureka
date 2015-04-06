//
//  EDOperationHandler.m
//  Edureka
//
//  Created by Neeraj Sharma on 04/04/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "EDOperationHandler.h"
#import "CommonBL.h"
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

- (void)getAuthTokenForApp:(NSMutableDictionary*)params WithCompletionBlock:(void (^)(NSMutableDictionary *, NSError *))completionBlock {
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",BASE_URL,AUTH_URL];
    
    [[AFHTTPRequestOperationManager manager] POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(responseObject)
        {
            NSMutableDictionary* dict = (NSMutableDictionary*) responseObject;
            if([[[dict objectForKey:@"data"] objectForKey:@"status"] intValue]==200)
            {
                [[CommonBL sharedInstance] parseAppAuthData:[dict objectForKey:@"data"]];
                if(completionBlock) completionBlock(responseObject,nil);
            }
            else{
                if(completionBlock) completionBlock(nil,[NSError errorWithDomain:@"" code:-2000 userInfo:nil]);
            }
        }
        else {
            if(completionBlock) completionBlock(nil,[NSError errorWithDomain:@"" code:-2000 userInfo:nil]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(completionBlock) completionBlock(nil,error);
    }];
}


@end
