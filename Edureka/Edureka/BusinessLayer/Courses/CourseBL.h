//
//  CourseBL.h
//  Edureka
//
//  Created by Neeraj Sharma on 26/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseBL : NSObject
+(CourseBL*)sharedInstance;

-(NSMutableArray*) getWishlistCourses;
-(NSMutableArray*) getRecommendedCourses;
-(NSMutableArray*) getNewCourses;
-(NSMutableArray*) getTrendingCourses;

-(NSMutableArray*) parseHomeCourseData:(NSMutableArray*) homeCourseArray;

@end
