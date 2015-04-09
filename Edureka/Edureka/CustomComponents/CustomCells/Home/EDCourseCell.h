//
//  EDCourseCell.h
//  Edureka
//
//  Created by Neeraj Sharma on 04/04/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDCourseCell : UITableViewCell
@property(nonatomic, strong) IBOutlet UIView* bgView;
@property(nonatomic, strong) IBOutlet UIImageView* courseImageView;
@property(nonatomic, strong) IBOutlet UILabel* courseLabel;
@property(nonatomic, strong) IBOutlet UIView* ratingView;
@property(nonatomic, strong) IBOutlet UIImageView* learnerImageView;
@property(nonatomic, strong) IBOutlet UILabel* learnerCountLabel;
@property(nonatomic, strong) IBOutlet UILabel* originalPriceLabel;
@property(nonatomic, strong) IBOutlet UILabel* discountedPriceLabel;

@end
