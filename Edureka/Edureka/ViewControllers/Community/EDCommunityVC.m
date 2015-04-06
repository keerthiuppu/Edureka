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

}
@end

@implementation EDCommunityVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
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

-(IBAction)segementControlSelected:(id)sender
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



@end
