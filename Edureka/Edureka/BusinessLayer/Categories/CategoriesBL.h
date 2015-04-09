//
//  CategoriesBL.h
//  Edureka
//
//  Created by Neeraj Sharma on 26/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoriesBL : NSObject
+(CategoriesBL*)sharedInstance;
-(NSMutableArray*) getAllCategories;
-(NSMutableArray*) parseCategoriesArray:(NSMutableArray*)categoriesArr;

@end
