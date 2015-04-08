//
//  EDCategoriesVC.m
//  Edureka
//
//  Created by Neeraj Sharma on 23/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "EDCategoriesVC.h"
#import "CategoriesBL.h"
#import "Categories.h"
#import "CategoryCell.h"
#import "EDCourseListVC.h"

@interface EDCategoriesVC ()
{
    NSMutableArray* categoriesArr;
    IBOutlet UITableView* categoryTableView;
}

@end

@implementation EDCategoriesVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureNavigationBar];
    [self registerCellsForTableView];
    
    categoriesArr = [[NSMutableArray alloc] initWithCapacity:0];
    [self getCategories];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Get Categories Listing
-(void) getCategories
{
    [APP_DELEGATE showLoadingBar];
    
    [[EDOperationHandler sharedInstance] getCategoriesWithParams:nil WithCompletionBlock:^(NSMutableArray *categoryArray, NSError *error) {
        //
        [APP_DELEGATE hideLoadingBar];
        [categoriesArr removeAllObjects];
        [categoriesArr addObjectsFromArray:categoryArray];
        [categoryTableView reloadData];
    }];

}



#pragma mark - UI Configuration
- (void)registerCellsForTableView
{
    UINib *nib = [UINib nibWithNibName:@"CategoryCell" bundle:[NSBundle mainBundle]];
    [categoryTableView registerNib:nib forCellReuseIdentifier:@"CategoryCell"];
    
    [categoryTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}


#pragma mark - UInavigationBar Configuration
-(void) configureNavigationBar{
    [self addRightMenuButton];
    [self addLeftMenuButton];
    
    UILabel* titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)];
    [titleLabel setText:@"Course categories"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [self.navigationItem setTitleView:titleLabel];
    
    //[self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"edurekaLogo"]]];
}

- (void)addLeftMenuButton{
    if (self.navigationItem.leftBarButtonItem == nil)
    {
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonTapped)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonTapped)];
        UIFont * font = [UIFont systemFontOfSize:14.0f];
        NSDictionary * attributes = @{NSFontAttributeName: font};
        [self.navigationItem.leftBarButtonItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
}

- (void)addRightMenuButton{
    if (self.navigationItem.rightBarButtonItem == nil){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButtontapped)];
    }
}

-(void) backButtonTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) searchButtontapped{

}

#pragma mark - UItableViewDelegate & Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [categoriesArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"CategoryCell";
    CategoryCell* cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    Categories* category =[categoriesArr objectAtIndex:indexPath.row];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    [cell.categoryNameLabel setText:category.categoryName];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 64.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDCourseListVC* edCourseListVC = [[EDCourseListVC alloc] initWithNibName:@"EDCourseListVC" bundle:nil];
    [self.navigationController pushViewController:edCourseListVC animated:YES];
}

@end
