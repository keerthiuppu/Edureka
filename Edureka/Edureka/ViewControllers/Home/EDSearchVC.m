//
//  EDSearchVC.m
//  Edureka
//
//  Created by keerthi uppu on 4/7/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "EDSearchVC.h"
#import "EDCourseCell.h"

@interface EDSearchVC ()

@end

@implementation EDSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self   searchRegisterCellsForTableView ];
          
    topSearches=[[NSArray alloc]initWithObjects:@"Javascript",@"Photoshop",@"JAVA",@"Python",@"PHP fundamentals",@"Android",@"iOS",@".NET", nil];
    
    searchResults=[[NSArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    searchBar.showsCancelButton = YES;
    
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)searchRegisterCellsForTableView
{
    UINib *nib = [UINib nibWithNibName:@"EDCourseCell" bundle:[NSBundle mainBundle]];
    [_searchResultsTableView registerNib:nib forCellReuseIdentifier:@"EDCourseCell"];
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [topSearches count];
    }

    
    
    
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"EDCourseCell";
    EDCourseCell* cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[EDCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    [cell.courseLabel setText:[topSearches objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 100.0f;
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [topSearches filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}



@end
