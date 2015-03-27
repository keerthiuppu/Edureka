//
//  UserBL.m
//  Edureka
//
//  Created by Neeraj Sharma on 26/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "UserBL.h"

@implementation UserBL

static UserBL* sharedObj = nil;

+(UserBL*)sharedInstance
{
    if(sharedObj==nil)
    {
        sharedObj=[[UserBL alloc]init];
    }
    return sharedObj;
}

-(BOOL) isUserLoggedIn
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_EMAIL]!=nil && [[[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_EMAIL] length]>0)
        return YES;
    else
        return NO;
}

@end
