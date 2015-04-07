//========================================================================
//  KelltonSettings.h
//  This file is created to decalre the properties and global metods
//  Created by Neeraj Sharma on 6/16/14.
//  Copyright (c) 2014 Neeraj Sharma. All rights reserved.
//========================================================================


#import <Foundation/Foundation.h>

typedef enum
{
    KelltonServerTypeProduction = 'P',
    KelltonServerTypeQA = 'Q',
    KelltonServerTypeDevlopment = 'D'
} KelltonServerType;

@interface KelltonSettings : NSObject {
    NSURL *clientServiceURL;
}

@property (nonatomic, copy, readonly) NSURL *clientServiceURL;

- (void)updateSettings;
+ (KelltonSettings *)sharedInstance;
+ (NSURL *)clientServiceURL;

@end
