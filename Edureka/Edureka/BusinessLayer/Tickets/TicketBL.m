//
//  TicketBL.m
//  Edureka
//
//  Created by keerthi uppu on 4/8/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "TicketBL.h"
#import "Ticket.h"

@implementation TicketBL


static TicketBL* sharedObj = nil;

+(TicketBL*)sharedInstance
{
    if(sharedObj==nil)
    {
        sharedObj=[[TicketBL alloc]init];
    }
    return sharedObj;
}

-(NSMutableArray*) getAllTickets:(NSMutableArray*)array
{
    
    NSMutableArray* ticketArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for(NSMutableDictionary* dict in ticketArray)
    {
        Ticket* tickets = [[Ticket alloc] initWithDictionary:dict];
        [ticketArray addObject:tickets];
    }
    return ticketArray;
}



@end
