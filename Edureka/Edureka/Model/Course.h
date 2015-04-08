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
@property(nonatomic, strong) NSString* rating;
@property(nonatomic, strong) NSString* numberOfLearners;
@property(nonatomic, strong) NSString* priceUSD;
@property(nonatomic, strong) NSString* priceINR;
@property(nonatomic, strong) NSString* discountedPriceUSD;
@property(nonatomic, strong) NSString* discountedPriceINR;


-(id) initWithDictionary:(NSMutableDictionary*) dictionary;

@end
