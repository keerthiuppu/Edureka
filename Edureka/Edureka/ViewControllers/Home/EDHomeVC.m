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

@interface EDHomeVC ()
{
    IBOutlet UITableView* courseTabelView;
    NSMutableArray* newCourseArray;
    NSMutableArray* trendingCourseArray;
    NSMutableArray* recommendedCourseArray;
    NSMutableArray* wishlistCourseArray;
}
@end

@implementation EDHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    newCourseArray = [[NSMutableArray alloc] initWithCapacity:0];
    trendingCourseArray = [[NSMutableArray alloc] initWithCapacity:0];
    recommendedCourseArray = [[NSMutableArray alloc] initWithCapacity:0];
    wishlistCourseArray = [[NSMutableArray alloc] initWithCapacity:0];
  
    //==========================================================
    [newCourseArray removeAllObjects];
    [newCourseArray addObjectsFromArray:[[CourseBL sharedInstance] getNewCourses]];
    
    [trendingCourseArray removeAllObjects];
    [trendingCourseArray addObjectsFromArray:[[CourseBL sharedInstance] getTrendingCourses]];
    
    [recommendedCourseArray removeAllObjects];
    [recommendedCourseArray addObjectsFromArray:[[CourseBL sharedInstance] getRecommendedCourses]];
    
    [wishlistCourseArray removeAllObjects];
    [wishlistCourseArray addObjectsFromArray:[[CourseBL sharedInstance] getWishlistCourses]];
    //==========================================================

    
    [self configureNavigationBar];
    [self registerCellsForTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Configuration
- (void)registerCellsForTableView
{
    UINib *nib = [UINib nibWithNibName:@"EDHomeCarouselCell" bundle:[NSBundle mainBundle]];
    [courseTabelView registerNib:nib forCellReuseIdentifier:@"EDHomeCarouselCell"];
    [courseTabelView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
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
    return [[UserBL sharedInstance] isUserLoggedIn] ? 4 : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier= @"EDHomeCarouselCell";
    EDHomeCarouselCell* cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    switch (indexPath.row)
    {
        case 0:
        {
            if ([[UserBL sharedInstance] isUserLoggedIn])
                [self configureWishlistCell:cell];
            else
                [self configureNewCourseCell:cell];
        }
            break;
        case 1:
        {
            if ([[UserBL sharedInstance] isUserLoggedIn])
                [self configureRecommendedCell:cell];
            else
                [self configureTrendingCourseCell:cell];
        }
            break;
        case 2:
        {
            [self configureNewCourseCell:cell];
        }
            break;
        case 3:
        {
            [self configureTrendingCourseCell:cell];
        }
            break;
        default:
            break;
    }
    
    [cell.carousel setDelegate:self];
    [cell.carousel setDataSource:self];
    
    [cell.carousel scrollToItemAtIndex:1 animated:NO];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200.0f;
}

-(void) configureRecommendedCell:(EDHomeCarouselCell*) cell
{
    [cell.carousel setTag:TAG_CAROUSEL_TYPE_RECOMMENDED];
    [cell.titleLabel setText:@"Recommended Courses"];
}

-(void) configureWishlistCell:(EDHomeCarouselCell*) cell
{
    [cell.carousel setTag:TAG_CAROUSEL_TYPE_WISHLIST];
    [cell.titleLabel setText:@"Wishlist Courses"];

}

-(void) configureNewCourseCell:(EDHomeCarouselCell*) cell
{
    [cell.carousel setTag:TAG_CAROUSEL_TYPE_NEW];
    [cell.titleLabel setText:@"New & Noteworthy Courses"];

}

-(void) configureTrendingCourseCell:(EDHomeCarouselCell*) cell
{
    [cell.carousel setTag:TAG_CAROUSEL_TYPE_TRENDING];
    [cell.titleLabel setText:@"Trending Courses"];

}

#pragma mark - iCarousel Delegate and DataSource methods
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    switch (carousel.tag) {
        case TAG_CAROUSEL_TYPE_RECOMMENDED:
            return recommendedCourseArray.count;
            break;
        case TAG_CAROUSEL_TYPE_WISHLIST:
            return wishlistCourseArray.count;
            break;
        case TAG_CAROUSEL_TYPE_NEW:
            return newCourseArray.count;
            break;
        case TAG_CAROUSEL_TYPE_TRENDING:
            return trendingCourseArray.count;
            break;
        default:
            return 0;
            break;
    }
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(EDCourseView *)view
{
    
    if (view == nil)
    {
        view = [[[NSBundle mainBundle] loadNibNamed:@"EDCourseView" owner:self options:nil] lastObject];
        view.backgroundColor = [UIColor whiteColor];
    }
    
    Course* course;
    switch (carousel.tag)
    {
        case TAG_CAROUSEL_TYPE_RECOMMENDED:
        {
            course = [recommendedCourseArray objectAtIndex:index];
        }
            break;
        case TAG_CAROUSEL_TYPE_WISHLIST:
        {
            course = [wishlistCourseArray objectAtIndex:index];
        }
            break;
        case TAG_CAROUSEL_TYPE_NEW:
        {
            course = [newCourseArray objectAtIndex:index];
        }
            break;
        case TAG_CAROUSEL_TYPE_TRENDING:
        {
            course = [trendingCourseArray objectAtIndex:index];
        }
            break;
    }

    [view.courseNameLabel setText:course.courseName];
    [view.courseImageView sd_setImageWithURL:[NSURL URLWithString:course.courseImageUrl] placeholderImage:[UIImage imageNamed:@"edurekaLogo"]];

    
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
