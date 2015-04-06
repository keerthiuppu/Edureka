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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavigationBar];
    [self registerCellsForTableView];
    categoriesArr = [[NSMutableArray alloc] initWithCapacity:0];
    [categoriesArr removeAllObjects];
    [categoriesArr addObjectsFromArray:[[CategoriesBL sharedInstance] getAllCategories]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
   // [self addRightMenuButton];
    [self addLeftMenuButton];
    self.title = @"Categories";
    
    //[self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"edurekaLogo"]]];
}

- (void)addLeftMenuButton{
    if (self.navigationItem.leftBarButtonItem == nil){
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonTapped)];
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
//    [cell.categoryImageView setImageType:@"Category"];
//    [cell.categoryImageView setImageFromUrlString:category.categoryImageUrl];
  
    [cell.categoryImageView sd_setImageWithURL:[NSURL URLWithString:category.categoryImageUrl] placeholderImage:[UIImage imageNamed:@"edurekaLogo"]];

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
