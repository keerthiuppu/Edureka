//
//  TicketCell.h
//  Edureka
//
//  Created by Neeraj Sharma on 01/04/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ticketIDLbl;
@property (weak, nonatomic) IBOutlet UILabel *ticketTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *postedDataLbl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;

@end
