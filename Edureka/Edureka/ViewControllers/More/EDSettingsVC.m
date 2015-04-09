//
//  EDMoreVC.m
//  Edureka
//
//  Created by Neeraj Sharma on 23/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "EDSettingsVC.h"
#import "EDProfileVC.h"
#import "EDContentDownloadVC.h"
#import "EDAboutVC.h"
#import "EDCommonWebViewVC.h"

@interface EDSettingsVC ()
{
    IBOutlet UITableView* settingsTableView;
}
@end

@implementation EDSettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 1;
            break;
        default:
            return 1;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    switch (indexPath.section) {
        case 0:
            [cell.textLabel setText:@"Profile"];
            break;
        case 1:
        {
            if(indexPath.row == 0)
                [cell.textLabel setText:@"Offline Ready Content"];
            else
                [cell.textLabel setText:@"Downloading Content"];
        }
            break;
        case 2:
        {
            if(indexPath.row == 0)
                [cell.textLabel setText:@"About"];
            else
                [cell.textLabel setText:@"FAQs & Support"];
        }
            break;
        case 3:
            [cell.textLabel setText:@"Privacy Policy"];
            break;
        case 4:
            [cell.textLabel setText:@"Logout"];
            break;
        default:
            [cell.textLabel setText:@"Default"];
            break;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            EDProfileVC* edProfileVC = [[EDProfileVC alloc] initWithNibName:@"EDProfileVC" bundle:nil];
            [self.navigationController pushViewController:edProfileVC animated:YES];
        }
            break;
        case 1:
        {
            EDContentDownloadVC* edContentDownloadVC = [[EDContentDownloadVC alloc] initWithNibName:@"EDContentDownloadVC" bundle:nil];
            if(indexPath.row == 0)
            {
                [edContentDownloadVC setIsDownloadingContentVC:NO];
            }
            else
            {
                [edContentDownloadVC setIsDownloadingContentVC:YES];
            }
            [self.navigationController pushViewController:edContentDownloadVC animated:YES];
        }
            break;
        case 2:
        {
            if(indexPath.row == 0)
            {
                EDAboutVC* edAboutVc =[[EDAboutVC alloc] initWithNibName:@"EDAboutVC" bundle:nil];
                [self.navigationController pushViewController:edAboutVc animated:YES];
            }
            else
            {
                EDCommonWebViewVC* edCommonWebVC = [[EDCommonWebViewVC alloc] initWithNibName:@"EDCommonWebViewVC" bundle:nil];
                [edCommonWebVC setTitleString:@"FAQs & Support"];
                [edCommonWebVC setUrlString:@"http://www.edureka.co/faq.html"];
                [self.navigationController pushViewController:edCommonWebVC animated:YES];
            }
        }
            break;
        case 3:
        {
            EDCommonWebViewVC* edCommonWebVC = [[EDCommonWebViewVC alloc] initWithNibName:@"EDCommonWebViewVC" bundle:nil];
            [edCommonWebVC setTitleString:@"Privacy Policy"];
            [edCommonWebVC setUrlString:@"http://www.edureka.co/privacy.html"];
            [self.navigationController pushViewController:edCommonWebVC animated:YES];
        }
            break;
        case 4:
        {
            [self callLogout];
        }
            break;
        default:
        {
        
        }
            break;
    }
}

-(void) callLogout
{
    
    [APP_DELEGATE showLoadingBar];
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dictionary setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KEY_SESSION_ID] forKey:@"sessionId"];
    
    [[EDOperationHandler sharedInstance] logoutUserWithParams:dictionary WithCompletionBlock:^(NSMutableDictionary *dict, NSError *error) {
        //
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_USER_EMAIL];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [APP_DELEGATE hideLoadingBar];
        [APP_DELEGATE navigateToLoginScreen];
    
    }];
}


@end
