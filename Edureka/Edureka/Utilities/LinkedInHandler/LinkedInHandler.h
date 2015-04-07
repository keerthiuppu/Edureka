//
//  LinkedInHandler.h
//  Edureka
//
//  Created by Neeraj Sharma on 07/04/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinkedInHandler : NSObject
+ (instancetype)sharedLinkedInHandler;

- (void)loginLinkedInForAppWithParams:(NSMutableDictionary *)params WithCompletionBlock:(void (^)(NSDictionary *dict, NSError *error))completionBlock;

@end
