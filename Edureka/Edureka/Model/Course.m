//
//  Course.m
//  Edureka
//
//  Created by Neeraj Sharma on 26/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "Course.h"

@implementation Course


-(id) initWithDictionary:(NSMutableDictionary*) dictionary
{
    if([dictionary objectForKey:@"courseId"])
        [self setCourseId:[dictionary objectForKey:@"courseId"]];
    
    if([dictionary objectForKey:@"courseName"])
        [self setCourseName:[dictionary objectForKey:@"courseName"]];
    
    if([dictionary objectForKey:@"courseImageUrl"])
        [self setCourseImageUrl:[dictionary objectForKey:@"courseImageUrl"]];
    
    return self;
}

@end
