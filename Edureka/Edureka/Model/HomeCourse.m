//
//  HomeCourse.m
//  Edureka
//
//  Created by Neeraj Sharma on 09/04/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "HomeCourse.h"

@implementation HomeCourse

-(id) initWithDictionary:(NSMutableDictionary*) dictionary
{
    if([dictionary objectForKey:@"categoryName"])
        [self setCategoryName:[dictionary objectForKey:@"categoryName"]];
    
    return self;
}
@end
