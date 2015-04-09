//
//  HomeCourse.h
//  Edureka
//
//  Created by Neeraj Sharma on 09/04/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCourse : NSObject

@property(nonatomic, strong) NSString* categoryName;
@property(nonatomic, strong) NSMutableArray* courseListArray;

-(id) initWithDictionary:(NSMutableDictionary*) dictionary;

@end
