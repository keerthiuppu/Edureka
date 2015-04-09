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

-(IBAction)loginButtonTapped:(id)sender;

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
    //[self addRightMenuButton];
    //[self addLeftMenuButton];
    
    UILabel* titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)];
    [titleLabel setText:@"Edureka account"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [self.navigationItem setTitleView:titleLabel];
    
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

-(IBAction)loginButtonTapped:(id)sender
{
    [self.view endEditing:YES];

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

#pragma mark - Validation Methods
-(BOOL) validate
{
    NSString* errorMessage = @"";
    
    if(emailTextField.text.length<=0)
        errorMessage = @"Please enter email address";
    else if(![self validateEmail:emailTextField.text])
        errorMessage = @"Please enter valid email address";
    else if(passwordTextField.text.length <= 0)
        errorMessage = @"Please enter password";
    else if(passwordTextField.text.length < 8)
        errorMessage = @"password length should be minimum 8 characters.";
    else{
    }
        
    if(errorMessage.length>0)
    {
        [[CommonBL sharedInstance] showErrorAlertWithMessage:errorMessage];
        return NO;
    }
    return YES;
}

-(BOOL) validateEmail:(NSString*) emailAddress
{
    //NSString *emailregex=@"[A-Za-z0-9%_+-.]+@[A-Za-z0-9,-]+\\.[A-Za-z]{2,4}";
    NSString *emailregex=@"[A-Za-z0-9%_+-.]+@[a-zA-Z0-9.-]+$";

    NSPredicate *emailTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailregex];
    return[emailTest evaluateWithObject:emailAddress];
}

#pragma mark - UITextField Delegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if(textField == emailTextField)
        [passwordTextField becomeFirstResponder];
    
    return YES;
}


@end
