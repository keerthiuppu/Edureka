//
//  CategoriesBL.m
//  Edureka
//
//  Created by Neeraj Sharma on 26/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "CategoriesBL.h"
#import "Categories.h"

@implementation CategoriesBL

static CategoriesBL* sharedObj = nil;

+(CategoriesBL*)sharedInstance
{
    if(sharedObj==nil)
    {
        sharedObj=[[CategoriesBL alloc]init];
    }
    return sharedObj;
}

-(NSMutableArray*) getAllCategories
{
    NSMutableArray* dictArr = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Categories" ofType:@"plist"]];
    NSMutableArray* categoriesArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for(NSMutableDictionary* dict in dictArr)
    {
        Categories* category = [[Categories alloc] initWithDictionary:dict];
        [categoriesArray addObject:category];
    }
    return categoriesArray;
}




@end
