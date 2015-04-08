//
//  EDCommunityVC.m
//  Edureka
//
//  Created by Neeraj Sharma on 01/04/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "EDCommunityVC.h"
#import "EDTicketVC.h"
#import "TicketCell.h"

@interface EDCommunityVC ()
{
    IBOutlet UITableView* ticketTableView;

    __weak IBOutlet UISegmentedControl *segmentedControl;
    BOOL hi;
}
@end

@implementation EDCommunityVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRightMenuButton];
    [self registerCellsForTableView];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) configureView
{
}


- (void)addRightMenuButton{
    if (self.navigationItem.rightBarButtonItem == nil){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addTicketButtonTapped:)];
    }
}

-(IBAction)addTicketButtonTapped:(id)sender
{

    
    
}

#pragma mark - UI Configuration
- (void)registerCellsForTableView
{
    UINib *nib = [UINib nibWithNibName:@"TicketCell" bundle:[NSBundle mainBundle]];
    [ticketTableView registerNib:nib forCellReuseIdentifier:@"TicketCell"];
    
    [ticketTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

#pragma mark - UItableViewDelegate & Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 4;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"TicketCell";
    TicketCell* cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115.0f;
}

- (IBAction)segementControlSelected:(id)sender {
   
    if(segmentedControl.selectedSegmentIndex == 0)
        {
          
        }
    else
    {
        NSLog(@"index 1");
    }
    
}
@end
