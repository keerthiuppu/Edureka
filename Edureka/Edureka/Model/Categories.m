//
//  Categories.m
//  Edureka
//
//  Created by Neeraj Sharma on 26/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "Categories.h"

@implementation Categories

-(id) initWithDictionary:(NSMutableDictionary*) dictionary
{
    if([dictionary objectForKey:@"categoryId"])
        [self setCategoryId:[dictionary objectForKey:@"categoryId"]];
    
    if([dictionary objectForKey:@"categoryName"])
        [self setCategoryName:[dictionary objectForKey:@"categoryName"]];
    
    if([dictionary objectForKey:@"imageUrl"])
        [self setCategoryImageUrl:[dictionary objectForKey:@"imageUrl"]];

    return self;
}

@end
