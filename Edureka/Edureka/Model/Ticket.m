//
//  Ticket.m
//  Edureka
//
//  Created by keerthi uppu on 4/8/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "Ticket.h"

@implementation Ticket



-(id) initWithDictionary:(NSMutableDictionary*) dictionary
{
    if([dictionary objectForKey:@"ticketId"])
        [self setTicketId:[dictionary objectForKey:@"ticketId"]];
    
    if([dictionary objectForKey:@"ticketTitle"])
        [self setTicketTitle:[dictionary objectForKey:@"ticketTitle"]];
    
    if([dictionary objectForKey:@"description"])
        [self setTicketDescription:[dictionary objectForKey:@"description"]];
    
    if([dictionary objectForKey:@"postedDate"])
        [self setTicketPostedDate:[dictionary objectForKey:@"postedDate"]];
    
    if([dictionary objectForKey:@"status"])
        [self setTicketStatus:[dictionary objectForKey:@"status"]];
   
    
    return self;
    

}



@end
