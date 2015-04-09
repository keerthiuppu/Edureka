//
//  EDRegisterVC.m
//  Edureka
//
//  Created by Neeraj Sharma on 23/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "EDRegisterVC.h"

@interface EDRegisterVC ()
{
    IBOutlet UITextField* firstNameTextField;
    IBOutlet UITextField* lastNameTextField;
    IBOutlet UITextField* emailTextField;
    IBOutlet UITextField* mobileTextField;
    IBOutlet UITextField* passwordTextField;
    IBOutlet UITextField* confirmPasswordTextField;
    
}
@end

@implementation EDRegisterVC

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
//    [self addRightMenuButton];
//    [self addLeftMenuButton];
    
    UILabel* titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)];
    [titleLabel setText:@"New Edureka account"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [self.navigationItem setTitleView:titleLabel];

    
   // [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"edurekaLogo"]]];
}

- (void)addLeftMenuButton{
    if (self.navigationItem.leftBarButtonItem == nil){
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonTapped)];
    }
}

- (void)addRightMenuButton{
    if (self.navigationItem.rightBarButtonItem == nil){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"SignUp" style:UIBarButtonItemStylePlain target:self action:@selector(signUpButtonTapped)];
    }
}

-(void) cancelButtonTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) signUpButtonTapped
{
    if([self validate])
    {
    [APP_DELEGATE showLoadingBar];
    
    NSMutableDictionary* paramsDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [paramsDict setObject:firstNameTextField.text forKey:@"first_name"];
    [paramsDict setObject:lastNameTextField.text forKey:@"last_name"];
    [paramsDict setObject:emailTextField.text forKey:@"email_address"];
    [paramsDict setObject:passwordTextField.text forKey:@"password"];
    if(mobileTextField.text.length>0)
        [paramsDict setObject:mobileTextField.text forKey:@"mobile_no"];
    else
        [paramsDict setObject:@"" forKey:@"mobile_no"];
        
    [paramsDict setObject:@"IN" forKey:@"country_code"];
    
    [[EDOperationHandler sharedInstance] registerUserWithParams:paramsDict WithCompletionBlock:^(NSMutableDictionary *dict, NSError *error) {
        //
        [APP_DELEGATE hideLoadingBar];
        [APP_DELEGATE configureTabBar];
    }];
    }
    
}

-(IBAction)registerButtonTapped:(id)sender
{
    [self.view endEditing:YES];

    if([self validate])
    {
        [APP_DELEGATE showLoadingBar];
        
        NSMutableDictionary* paramsDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        [paramsDict setObject:firstNameTextField.text forKey:@"first_name"];
        [paramsDict setObject:lastNameTextField.text forKey:@"last_name"];
        [paramsDict setObject:emailTextField.text forKey:@"email_address"];
        [paramsDict setObject:passwordTextField.text forKey:@"password"];
        if(mobileTextField.text.length>0)
            [paramsDict setObject:mobileTextField.text forKey:@"mobile_no"];
        else
            [paramsDict setObject:@"" forKey:@"mobile_no"];
        
        [paramsDict setObject:@"IN" forKey:@"country_code"];
        
        [[EDOperationHandler sharedInstance] registerUserWithParams:paramsDict WithCompletionBlock:^(NSMutableDictionary *dict, NSError *error) {
            //
            [APP_DELEGATE hideLoadingBar];
            [APP_DELEGATE configureTabBar];
        }];
    }
}

#pragma mark - Validation Methods
-(BOOL) validate
{
    NSString* errorMessage = @"";
    
    if(firstNameTextField.text.length<=0)
        errorMessage = @"Please enter first name";
    else if(lastNameTextField.text.length<=0)
        errorMessage = @"Please enter last name";
    else if(emailTextField.text.length<=0)
        errorMessage = @"Please enter email address";
    else if(![self validateEmail:emailTextField.text])
        errorMessage = @"Please enter valid email address";
    else if(mobileTextField.text.length>0 && mobileTextField.text.length!=10)
        errorMessage = @"Please enter valid mobile number";
    else if(passwordTextField.text.length <= 0)
        errorMessage = @"Please enter password";
    else if(passwordTextField.text.length < 8)
        errorMessage = @"password length should be minimum 8 characters.";
    else if(![passwordTextField.text isEqualToString:confirmPasswordTextField.text])
        errorMessage = @"Password and confirm password does not match";
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
    
    if(textField == firstNameTextField)
        [lastNameTextField becomeFirstResponder];
    else if(textField == lastNameTextField)
        [emailTextField becomeFirstResponder];
    else if(textField == emailTextField)
        [mobileTextField becomeFirstResponder];
    else if(textField == mobileTextField)
        [passwordTextField becomeFirstResponder];
    else if(textField == passwordTextField)
        [confirmPasswordTextField becomeFirstResponder];
    else{
    
    }
    
    return YES;
}


@end
