//
//  Course.h
//  Edureka
//
//  Created by Neeraj Sharma on 26/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject
@property(nonatomic, strong) NSString* courseId;
@property(nonatomic, strong) NSString* courseName;
@property(nonatomic, strong) NSString* courseImageUrl;

-(id) initWithDictionary:(NSMutableDictionary*) dictionary;

@end
