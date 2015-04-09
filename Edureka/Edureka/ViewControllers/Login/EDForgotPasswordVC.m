//
//  EDForgotPasswordVC.m
//  Edureka
//
//  Created by Neeraj Sharma on 23/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "EDForgotPasswordVC.h"

@interface EDForgotPasswordVC ()
{
    IBOutlet UITextField* emailTextField;
}
@end

@implementation EDForgotPasswordVC

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
    
//    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"edurekaLogo"]]];
    
    UILabel* titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)];
    [titleLabel setText:@"Forgot Password"];
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
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(sendbuttonTapped)];
    }
}

-(void) cancelButtonTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) sendbuttonTapped{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:APP_NAME message:@"Your password has been sent to your Email Address successfully." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)submitButtonTapped:(id)sender
{
    [self.view endEditing:YES];
    if([self validate])
    {
        [APP_DELEGATE showLoadingBar];
        
        NSMutableDictionary* paramsDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        [paramsDict setObject:emailTextField.text forKey:@"email_address"];
        [[EDOperationHandler sharedInstance] forgotPasswordWithParams:paramsDict WithCompletionBlock:^(NSMutableDictionary *dict, NSError *error) {
            //
            if([[dict objectForKey:@"data"] objectForKey:@"message"])
            {
                [APP_DELEGATE hideLoadingBar];
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:APP_NAME message:[[dict objectForKey:@"data"] objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
            }
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
    NSString *emailregex=@"[A-Za-z0-9%_+-.]+@[a-zA-Z0-9.-]+$";
    NSPredicate *emailTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailregex];
    return[emailTest evaluateWithObject:emailAddress];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
