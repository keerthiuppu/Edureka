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


@end
