//
//  EDHomeVC.m
//  Edureka
//
//  Created by Neeraj Sharma on 23/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "EDHomeVC.h"
#import "EDCategoriesVC.h"
#import "EDHomeCarouselCell.h"
#import "UserBL.h"
#import "EDCourseView.h"
#import "CourseBL.h"
#import "Course.h"
#import "EDSearchVC.h"
#import "HomeCourse.h"

@interface EDHomeVC ()
{
    IBOutlet UITableView* courseTabelView;
    NSMutableArray* homeCoursesArray;
}
@end

@implementation EDHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    homeCoursesArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self configureNavigationBar];
    [self registerCellsForTableView];
    
    [self getCourseListing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getCourseListing
{
    [APP_DELEGATE showLoadingBar];
    
    [[EDOperationHandler sharedInstance] getHomeCoursesWithParams:nil WithCompletionBlock:^(NSMutableArray *courseArray, NSError *error) {
        //
        [APP_DELEGATE hideLoadingBar];
        
        [homeCoursesArray removeAllObjects];
        [homeCoursesArray addObjectsFromArray:courseArray];
        [courseTabelView reloadData];
    }];
    
}

#pragma mark - UI Configuration
- (void)registerCellsForTableView
{
    UINib *nib = [UINib nibWithNibName:@"EDHomeCarouselCell" bundle:[NSBundle mainBundle]];
    [courseTabelView registerNib:nib forCellReuseIdentifier:@"EDHomeCarouselCell"];
    [courseTabelView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [courseTabelView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

#pragma mark - UInavigationBar Configuration
-(void) configureNavigationBar{
    [self addRightMenuButton];
    [self addLeftMenuButton];
    
    UILabel* titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)];
    [titleLabel setText:@"Home"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [self.navigationItem setTitleView:titleLabel];
//    
//    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"edurekaLogo"]]];
}

- (void)addLeftMenuButton{
    if (self.navigationItem.leftBarButtonItem == nil){
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Categories" style:UIBarButtonItemStylePlain target:self action:@selector(categoriesButtonTapped)];
        UIFont * font = [UIFont systemFontOfSize:14.0f];
        NSDictionary * attributes = @{NSFontAttributeName: font};
        [self.navigationItem.leftBarButtonItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
}

- (void)addRightMenuButton{
    if (self.navigationItem.rightBarButtonItem == nil)
    {
        UIBarButtonItem* wishListBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(searchButtontapped)];
       
         UIBarButtonItem* searchBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButtontapped)];
    
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:searchBarButton, wishListBarButton, nil];
    }
}

-(void) categoriesButtonTapped{
    EDCategoriesVC* edCategoriesVC = [[EDCategoriesVC alloc] initWithNibName:@"EDCategoriesVC" bundle:nil];
    [self.navigationController pushViewController:edCategoriesVC animated:YES];
}

-(void) searchButtontapped{
    
    EDSearchVC* edSearchVC = [[EDSearchVC alloc] initWithNibName:@"EDSearchVC" bundle:nil];
    
    [self presentViewController:edSearchVC animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate & Datasource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return homeCoursesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier= @"EDHomeCarouselCell";
    EDHomeCarouselCell* cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    HomeCourse* homeCourse = [homeCoursesArray objectAtIndex:indexPath.row];
    [cell.titleLabel setText:homeCourse.categoryName];
    [cell.carousel setTag:indexPath.row+K_CAROUSEL_OFFSET];
    
    [cell.carousel setDelegate:self];
    [cell.carousel setDataSource:self];
   
    if(homeCourse.courseListArray.count>1)
        [cell.carousel scrollToItemAtIndex:1 animated:NO];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 225.0f;
}


#pragma mark - iCarousel Delegate and DataSource methods
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    HomeCourse* homeCourse = [homeCoursesArray objectAtIndex:carousel.tag - K_CAROUSEL_OFFSET];
    return homeCourse.courseListArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(EDCourseView *)view
{
    
    if (view == nil)
    {
        view = [[[NSBundle mainBundle] loadNibNamed:@"EDCourseView" owner:self options:nil] lastObject];
        view.backgroundColor = [UIColor whiteColor];
        [view.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [view.layer setBorderWidth:1.0f];
    }
    
    HomeCourse* homeCourse = [homeCoursesArray objectAtIndex:carousel.tag - K_CAROUSEL_OFFSET];
    Course* course = [homeCourse.courseListArray objectAtIndex:index];

    [view.courseNameLabel setText:course.courseName];
    [view.courseImageView sd_setImageWithURL:[NSURL URLWithString:course.courseImageUrl] placeholderImage:[UIImage imageNamed:@"edurekaLogo"]];
    [view.learnersLabel setText:[NSString stringWithFormat:@"%@ learners", course.numberOfLearners]];
    [view.starRatingView setCanEdit:NO];
    [view.starRatingView setMaxRating:5];
    [view.starRatingView setRating:[course.rating floatValue]];
    [view.discountedPriceLabel  setText:[NSString stringWithFormat:@"INR %@", course.discountedPriceINR]];
   
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"INR %@", course.priceINR]];
    [attributeString addAttribute:NSStrikethroughStyleAttributeName
                            value:@2
                            range:NSMakeRange(0, [attributeString length])];
    [view.originalPriceLabel  setAttributedText:attributeString];
    
    
    
    return view;
    
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1f;
    }
 return value;
}



@end
