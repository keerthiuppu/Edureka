//
//  EDCourseListVC.m
//  Edureka
//
//  Created by Neeraj Sharma on 04/04/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "EDCourseListVC.h"
#import "EDCourseCell.h"

@interface EDCourseListVC ()
{
    IBOutlet UITableView* courseTableView;
}

@end

@implementation EDCourseListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavigationBar];
    [self registerCellsForTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UInavigationBar Configuration
-(void) configureNavigationBar{
    // [self addRightMenuButton];
    [self addLeftMenuButton];
    self.title = @"Linux";
    
    //[self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"edurekaLogo"]]];
}

- (void)addLeftMenuButton{
    if (self.navigationItem.leftBarButtonItem == nil){
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonTapped)];
    }
}


-(void) backButtonTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UI Configuration
- (void)registerCellsForTableView
{
    UINib *nib = [UINib nibWithNibName:@"EDCourseCell" bundle:[NSBundle mainBundle]];
    [courseTableView registerNib:nib forCellReuseIdentifier:@"EDCourseCell"];
    
    [courseTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}


#pragma mark - UItableViewDelegate & Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"EDCourseCell";
    EDCourseCell* cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}


@end
