//
//  CourseBL.m
//  Edureka
//
//  Created by Neeraj Sharma on 26/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "CourseBL.h"
#import "Course.h"

@implementation CourseBL

static CourseBL* sharedObj = nil;

+(CourseBL*)sharedInstance
{
    if(sharedObj==nil)
    {
        sharedObj=[[CourseBL alloc]init];
    }
    return sharedObj;
}


-(NSMutableArray*) getWishlistCourses
{
    NSMutableArray* dictArr = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Wishlist" ofType:@"plist"]];
    NSMutableArray* courseArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for(NSMutableDictionary* dict in dictArr)
    {
        Course* course = [[Course alloc] initWithDictionary:dict];
        [courseArray addObject:course];
    }
    return courseArray;
}

-(NSMutableArray*) getRecommendedCourses
{
    NSMutableArray* dictArr = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Recommended" ofType:@"plist"]];
    NSMutableArray* courseArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for(NSMutableDictionary* dict in dictArr)
    {
        Course* course = [[Course alloc] initWithDictionary:dict];
        [courseArray addObject:course];
    }
    return courseArray;
}

-(NSMutableArray*) getNewCourses
{
    NSMutableArray* dictArr = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewCourses" ofType:@"plist"]];
    NSMutableArray* courseArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for(NSMutableDictionary* dict in dictArr)
    {
        Course* course = [[Course alloc] initWithDictionary:dict];
        [courseArray addObject:course];
    }
    return courseArray;
}

-(NSMutableArray*) getTrendingCourses
{
    NSMutableArray* dictArr = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Trending" ofType:@"plist"]];
    NSMutableArray* courseArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for(NSMutableDictionary* dict in dictArr)
    {
        Course* course = [[Course alloc] initWithDictionary:dict];
        [courseArray addObject:course];
    }
    return courseArray;
}

@end
