//
//  Categories.h
//  Edureka
//
//  Created by Neeraj Sharma on 26/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Categories : NSObject

@property(nonatomic, strong) NSString* categoryId;
@property(nonatomic, strong) NSString* categoryName;
@property(nonatomic, strong) NSString* categoryImageUrl;


-(id) initWithDictionary:(NSMutableDictionary*) dictionary;

@end
