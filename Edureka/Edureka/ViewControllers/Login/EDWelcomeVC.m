//
//  EDWelcomeVC.m
//  Edureka
//
//  Created by Neeraj Sharma on 23/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "EDWelcomeVC.h"
#import "EDLoginVC.h"
#import "EDRegisterVC.h"
#import "EDForgotPasswordVC.h"
#import "AppDelegate.h"
#import "FBHandler.h"
#import "LinkedInHandler.h"

@interface EDWelcomeVC ()

@end

@implementation EDWelcomeVC

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    [self configureNavigationBar];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UInavigationBar Configuration
-(void) configureNavigationBar
{
    [self addRightMenuButton];
    
    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"edurekaLogo"]]];
    
}

- (void)addRightMenuButton{
    if (self.navigationItem.rightBarButtonItem == nil){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Browse" style:UIBarButtonItemStylePlain target:self action:@selector(browseButtonTapped)];
    }
}

-(void) browseButtonTapped
{
    [APP_DELEGATE configureTabBar];
}

#pragma mark - Action Methods
-(IBAction)loginButtonTapped:(id)sender
{
    EDLoginVC* edLoginVC = [[EDLoginVC alloc] initWithNibName:@"EDLoginVC" bundle:nil];
    [self.navigationController pushViewController:edLoginVC animated:YES];
}

-(IBAction)registerButtonTapped:(id)sender
{
    EDRegisterVC* edRegisterVC = [[EDRegisterVC alloc] initWithNibName:@"EDRegisterVC" bundle:nil];
    [self.navigationController pushViewController:edRegisterVC animated:YES];
}

-(IBAction)facebookLoginButtonTapped:(id)sender
{
    [[FBHandler sharedFBHandler] loginFacebookWithSuccessBlock:^(BOOL success) {
        //
        [[FBHandler sharedFBHandler] fetchUserInfoWithSuccessBlock:^(NSDictionary *userInfo) {
            
            NSLog(@"Fb Usr info--->%@", [userInfo description]);
            
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:APP_NAME message:[NSString stringWithFormat:@"Welcome, %@ %@", [userInfo objectForKey:@"first_name"], [userInfo objectForKey:@"last_name"]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            //
        } failureBlock:^(NSError *error) {
            //
        }];
        
    } failureBlock:^(NSError *error) {
        
        
    }];
}

-(IBAction)linkedInLoginButtonTapped:(id)sender
{
    [[LinkedInHandler sharedLinkedInHandler] loginLinkedInForAppWithParams:nil WithCompletionBlock:^(NSDictionary *dict, NSError *error) {
        
        NSLog(@"LinkedIn User Info--> %@", [dict description]);
        //
    }];

}

-(IBAction)forgotPasswordLoginButtonTapped:(id)sender
{
    EDForgotPasswordVC* edPasswordVC = [[EDForgotPasswordVC alloc] initWithNibName:@"EDForgotPasswordVC" bundle:nil];
    [self.navigationController pushViewController:edPasswordVC animated:YES];
}

@end
