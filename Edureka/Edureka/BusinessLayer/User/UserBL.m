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

-(void) parseUserData:(NSMutableDictionary*) dictionary
{
    if([dictionary objectForKey:@"emailAddress"])
        [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:@"emailAddress"] forKey:KEY_USER_EMAIL];
   
    if([dictionary objectForKey:@"firstName"])
        [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:@"firstName"] forKey:KEY_USER_FIRST_NAME];
  
    if([dictionary objectForKey:@"lastName"])
        [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:@"lastName"] forKey:KEY_USER_LAST_NAME];
    
    if([dictionary objectForKey:@"mobileNo"])
        [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:@"mobileNo"] forKey:KEY_USER_MOBILE_NO];
    
    if([dictionary objectForKey:@"sessionId"])
        [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:@"sessionId"] forKey:KEY_USER_SESSION_ID];
   
    if([dictionary objectForKey:@"userId"])
        [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:@"userId"] forKey:KEY_USER_ID];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
