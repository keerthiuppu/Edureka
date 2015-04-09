//
//  TicketBL.h
//  Edureka
//
//  Created by keerthi uppu on 4/8/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketBL : NSObject
+(TicketBL*)sharedInstance;

-(NSMutableArray*) getAllTickets:(NSMutableArray*)array;


@end
