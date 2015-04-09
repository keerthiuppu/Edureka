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
    
    if([dictionary objectForKey:@"iconUrl"]){
     
        if([[dictionary objectForKey:@"iconUrl"] rangeOfString:@"http://acdn.edureka.co/"].location == NSNotFound)
            [self setCourseImageUrl:[NSString stringWithFormat:@"http://acdn.edureka.co/%@", [dictionary objectForKey:@"iconUrl"]]];
        else
            [self setCourseImageUrl:[dictionary objectForKey:@"iconUrl"]];
    }
 
    if([dictionary objectForKey:@"rating"])
        [self setRating:[dictionary objectForKey:@"rating"]];
    
    if([dictionary objectForKey:@"numberOfLearners"])
        [self setNumberOfLearners:[dictionary objectForKey:@"numberOfLearners"]];
    
    if([dictionary objectForKey:@"price_usd"])
        [self setPriceUSD:[dictionary objectForKey:@"price_usd"]];
    
    if([dictionary objectForKey:@"price_inr"])
        [self setPriceINR:[dictionary objectForKey:@"price_inr"]];
    
    if([dictionary objectForKey:@"discount_price_usd"])
        [self setDiscountedPriceUSD:[dictionary objectForKey:@"discount_price_usd"]];
  
    if([[dictionary objectForKey:@"discount_price_inr"] isKindOfClass:[NSString class]])
        [self setDiscountedPriceINR:[dictionary objectForKey:@"discount_price_inr"]];
    else if([[dictionary objectForKey:@"discount_price_inr"] isKindOfClass:[NSNumber class]])
        [self setDiscountedPriceINR:[[dictionary objectForKey:@"discount_price_inr"] stringValue]];
    else{}
    
    return self;
}

@end
