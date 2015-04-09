//
//  CommonBL.h
//  Edureka
//
//  Created by Neeraj Sharma on 26/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonBL : NSObject
+(CommonBL*)sharedInstance;

-(void) parseAppAuthData:(NSMutableDictionary*) dictionary;
-(BOOL) isAuthTokenAvailable;
-(void) showErrorAlertWithMessage:(NSString*) messageStr;
@end
