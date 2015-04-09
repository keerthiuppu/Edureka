//
//  Ticket.h
//  Edureka
//
//  Created by keerthi uppu on 4/8/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject


@property(nonatomic, strong) NSString* ticketId;
@property(nonatomic, strong) NSString* ticketTitle;
@property(nonatomic, strong) NSString* ticketDescription;
@property(nonatomic, strong) NSString* ticketPostedDate;
@property(nonatomic, strong) NSString* ticketStatus;

-(id) initWithDictionary:(NSMutableDictionary*) dictionary;

@end
