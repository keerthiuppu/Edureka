//
//  EDCourseCell.m
//  Edureka
//
//  Created by Neeraj Sharma on 04/04/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "EDCourseCell.h"

@implementation EDCourseCell

- (void)awakeFromNib
{
    // Initialization code
    [_bgView.layer setBorderWidth:1.0f];
    [_bgView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
