//
//  EDMyCourseVC.m
//  Edureka
//
//  Created by Neeraj Sharma on 23/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "EDMyCourseVC.h"
#import "EDMyCourseCell.h"

@interface EDMyCourseVC ()
{
    IBOutlet UITableView* myCourseTableView;
}
@end

@implementation EDMyCourseVC

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UInavigationBar Configuration
-(void) configureNavigationBar{
    // [self addRightMenuButton];
    //[self addLeftMenuButton];
    self.title = @"My Courses";
    
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
    UINib *nib = [UINib nibWithNibName:@"EDMyCourseCell" bundle:[NSBundle mainBundle]];
    [myCourseTableView registerNib:nib forCellReuseIdentifier:@"EDMyCourseCell"];
    
    [myCourseTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}


#pragma mark - UItableViewDelegate & Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"EDMyCourseCell";
    EDMyCourseCell* cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125.0f;
}



@end
