//
//  CommonBL.m
//  Edureka
//
//  Created by Neeraj Sharma on 26/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "CommonBL.h"

@implementation CommonBL

static CommonBL* sharedObj = nil;

+(CommonBL*)sharedInstance
{
    if(sharedObj==nil)
    {
        sharedObj=[[CommonBL alloc]init];
    }
    return sharedObj;
}

-(void) parseAppAuthData:(NSMutableDictionary*) dictionary
{
    if([[dictionary objectForKey:@"token"] isKindOfClass:[NSString class]])
        [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:@"token"] forKey:KEY_TOKEN_ID];
    else if([[dictionary objectForKey:@"token"] isKindOfClass:[NSNumber class]])
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", [[dictionary objectForKey:@"token"] intValue]] forKey:KEY_TOKEN_ID];
    else
        [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:@"token"] forKey:KEY_TOKEN_ID];

    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL) isAuthTokenAvailable
{
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:KEY_TOKEN_ID]!=nil || [[[NSUserDefaults standardUserDefaults] objectForKey:KEY_TOKEN_ID] length]>0)
        return YES;
    else
        return NO;
}

-(void) showErrorAlertWithMessage:(NSString*) messageStr
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:APP_NAME message:messageStr delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}


@end
