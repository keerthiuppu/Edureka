//
//  EDCourseView.h
//  Edureka
//
//  Created by Neeraj Sharma on 26/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"

@interface EDCourseView : UIView
@property(nonatomic, strong) IBOutlet UILabel* courseNameLabel;
@property(nonatomic, strong) IBOutlet UIImageView* courseImageView;
@property(nonatomic, strong) IBOutlet UILabel* learnersLabel;
@property(nonatomic, strong) IBOutlet UILabel* discountedPriceLabel;
@property(nonatomic, strong) IBOutlet UILabel* originalPriceLabel;
@property(nonatomic, strong) IBOutlet ASStarRatingView * starRatingView;


@end
