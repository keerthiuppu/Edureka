//
//  UserBL.h
//  Edureka
//
//  Created by Neeraj Sharma on 26/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserBL : NSObject
+(UserBL*)sharedInstance;

-(BOOL) isUserLoggedIn;

@end
