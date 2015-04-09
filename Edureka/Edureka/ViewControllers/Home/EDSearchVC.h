//
//  EDSearchVC.h
//  Edureka
//
//  Created by keerthi uppu on 4/7/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDSearchVC : UIViewController<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>
{
    NSArray *topSearches;
    
    NSArray *searchResults;
    
    __weak IBOutlet UISearchBar *searchBar;


}
@property (weak, nonatomic) IBOutlet UITableView *searchResultsTableView;
@end
