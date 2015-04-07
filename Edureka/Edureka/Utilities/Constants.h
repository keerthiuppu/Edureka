//
//  Constants.h
//  Edureka
//
//  Created by Neeraj Sharma on 23/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#ifndef Edureka_Constants_h
#define Edureka_Constants_h

#define APP_NAME        @"Edureka"
#define APP_DELEGATE    (AppDelegate*)[UIApplication sharedApplication].delegate

//#define BASE_URL        @"https://dev.edurekaglobal.com/"

#define BASE_URL [KelltonSettings clientServiceURL]

#define AUTH_URL         @"authapi"
#define LOGIN_URL        @"users/login"
#define REGISTER_URL     @"users/registration"
#define LOGOUT_URL       @"users/logout"


#define COLOR_NAVIGATION_BAR   [UIColor colorWithRed:27.0/255.0f green:81.0f/255.0f blue:150.0f/255.0f alpha:1.0f]

#define KEY_TOKEN_ID        @"TokenId"
#define KEY_SESSION_ID      @"SessionId"
#define KEY_API             @"Edureka2015"


#define TAG_CAROUSEL_TYPE_RECOMMENDED   222
#define TAG_CAROUSEL_TYPE_WISHLIST      223
#define TAG_CAROUSEL_TYPE_NEW           224
#define TAG_CAROUSEL_TYPE_TRENDING      225


#define KEY_USER_EMAIL          @"EmailAddress"
#define KEY_USER_FIRST_NAME     @"FirstName"
#define KEY_USER_LAST_NAME      @"LastName"
#define KEY_USER_ID             @"UserId"
#define KEY_USER_MOBILE_NO      @"MobileNo"
#define KEY_USER_SESSION_ID     @"SessionId"

#endif
