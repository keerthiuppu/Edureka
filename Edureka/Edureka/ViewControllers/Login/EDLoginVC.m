//
//  EDLoginVC.m
//  Edureka
//
//  Created by Neeraj Sharma on 23/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "EDLoginVC.h"

@interface EDLoginVC ()
{
    IBOutlet UITextField* emailTextField;
    IBOutlet UITextField* passwordTextField;
}
@end

@implementation EDLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavigationBar];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UInavigationBar Configuration
-(void) configureNavigationBar{
    [self addRightMenuButton];
    [self addLeftMenuButton];
    
    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"edurekaLogo"]]];
}

- (void)addLeftMenuButton{
    if (self.navigationItem.leftBarButtonItem == nil){
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonTapped)];
    }
}

- (void)addRightMenuButton{
    if (self.navigationItem.rightBarButtonItem == nil){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStylePlain target:self action:@selector(loginButtonTapped)];
    }
}

-(void) cancelButtonTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) loginButtonTapped
{
   if([self validate])
   {
       [APP_DELEGATE showLoadingBar];
       
       NSMutableDictionary* paramsDict = [[NSMutableDictionary alloc] initWithCapacity:0];
       [paramsDict setObject:emailTextField.text forKey:@"email_address"];
       [paramsDict setObject:passwordTextField.text forKey:@"password"];
       

       [[EDOperationHandler sharedInstance] loginUserWithParams:paramsDict WithCompletionBlock:^(NSMutableDictionary *dict, NSError *error) {
 
           [APP_DELEGATE hideLoadingBar];
           [APP_DELEGATE configureTabBar];
       }];
   }
    
   
}

-(BOOL) validate
{

    return YES;
}



@end
