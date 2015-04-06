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
    if([dictionary objectForKey:@"token"])
        [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:@"token"] forKey:KEY_TOKEN_ID];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) showErrorAlertWithMessage:(NSString*) messageStr
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:APP_NAME message:messageStr delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}


@end
