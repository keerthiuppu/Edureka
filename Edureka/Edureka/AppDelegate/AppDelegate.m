//
//  AppDelegate.m
//  Edureka
//
//  Created by Neeraj Sharma on 17/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import "AppDelegate.h"
#import "EDWelcomeVC.h"
#import "EDHomeVC.h"
#import "EDMyCourseVC.h"
#import "EDTicketVC.h"
#import "EDRedeemVC.h"
#import "EDSettingsVC.h"
#import "EDCommunityVC.h"
#import "EDOperationHandler.h"

@interface AppDelegate ()
{
    UINavigationController* navController;
    UIView* loadingView;
}
@end

@implementation AppDelegate
#define RADIANS(degrees) ((degrees * M_PI) / 180.0)


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self configureNavigationBar];
    
    
    //    NSLocale *locale = [NSLocale currentLocale];
    //    NSArray *countryArray = [NSLocale ISOCountryCodes];
    //
    //    NSMutableArray *sortedCountryArray = [[NSMutableArray alloc] init];
    //
    //    for (NSString *countryCode in countryArray) {
    //
    //        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
    //        [sortedCountryArray addObject:displayNameString];
    //        NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    //        NSLog(@"CountryCode=%@ & countryName=%@", countryCode, displayNameString);
    //    }
    //
    //
    //     NSArray *localeArray  = [NSLocale ISOCountryCodes];
    //    NSLocale *locale = [NSLocale currentLocale];
    //    for (NSString *countryCode in localeArray) {
    //     NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
    //        NSLog(@"Country Code=%@ --- Country Name=%@", countryCode, displayNameString);
    
    
    //        NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    //        NSLog(@"CountryCode=%@ & countryName=%@", countryCode);
    //    }
    
    
    //  [sortedCountryArray sortUsingSelector:@selector(localizedCompare:)];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    EDWelcomeVC* edWelcomeVC = [[EDWelcomeVC alloc] initWithNibName:@"EDWelcomeVC" bundle:nil];
    navController = [[UINavigationController alloc] initWithRootViewController:edWelcomeVC];
    [self.window addSubview:navController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark- Get App Auth Token
-(void) getAppAthToken
{
//    NSMutableDictionary* paramsDict = [[NSMutableDictionary alloc] initWithCapacity:0];
//    
//    
//    
//    [[EDOperationHandler sharedInstance] getAuthTokenForApp:paramsDict WithCompletionBlock:^(NSMutableDictionary *dict, NSError *error) {
//        //
//        if(error)
//            
//    }];
}

#pragma mark UI Configuration
-(void) configureNavigationBar
{
    [[UINavigationBar appearance] setBarTintColor:COLOR_NAVIGATION_BAR];
    
    if([UINavigationBar conformsToProtocol:@protocol(UIAppearanceContainer)]) {
        [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    }
    
}

-(void) configureTabBar
{
    
    EDHomeVC* edHomeVC = [[EDHomeVC alloc] initWithNibName:@"EDHomeVC" bundle:nil];
    EDMyCourseVC* edMyCourseVC = [[EDMyCourseVC alloc] initWithNibName:@"EDMyCourseVC" bundle:nil];
    EDCommunityVC* edCommunityVC = [[EDCommunityVC alloc] initWithNibName:@"EDCommunityVC" bundle:nil];
    EDRedeemVC* edRedeemVC = [[EDRedeemVC alloc] initWithNibName:@"EDRedeemVC" bundle:nil];
    EDSettingsVC* edSettingsVC = [[EDSettingsVC alloc] initWithNibName:@"EDSettingsVC" bundle:nil];
    
    edHomeVC.title = @"Home";
    edHomeVC.tabBarItem.image = [UIImage imageNamed:@"home"];
    
    edMyCourseVC.title=@"My Courses";
    edMyCourseVC.tabBarItem.image = [UIImage imageNamed:@"myCourse"];
    
    edCommunityVC.title = @"Community";
    edCommunityVC.tabBarItem.image = [UIImage imageNamed:@"ticket"];
    
    edRedeemVC.title= @"Redeem";
    edRedeemVC.tabBarItem.image = [UIImage imageNamed:@"forum"];
    
    edSettingsVC.title = @"Settings";
    edSettingsVC.tabBarItem.image = [UIImage imageNamed:@"more"];
    
    UINavigationController* homeNavControl =[[UINavigationController alloc] initWithRootViewController:edHomeVC];
    UINavigationController* myCourseNavControl =[[UINavigationController alloc] initWithRootViewController:edMyCourseVC];
    UINavigationController* ticketNavControl =[[UINavigationController alloc] initWithRootViewController:edCommunityVC];
    UINavigationController* redeemNavControl =[[UINavigationController alloc] initWithRootViewController:edRedeemVC];
    UINavigationController* settingsNavControl =[[UINavigationController alloc] initWithRootViewController:edSettingsVC];
    
    
    //create an array of all view controllers that will represent the tab at the bottom
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:homeNavControl, myCourseNavControl,ticketNavControl,redeemNavControl, settingsNavControl, nil];
    //initialize the tab bar controller
    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController setViewControllers:viewControllers];
    [self.window addSubview:self.tabBarController.view];
}

#pragma mark - Loading Bar
-(void) showLoadingBar
{
    if(loadingView==nil)
    {
        loadingView = [[UIView alloc] initWithFrame:self.window.frame];
        [loadingView setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.6f]];
        [self.window addSubview:loadingView];
        
        //        UIActivityIndicatorView* activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        //        [activityView setCenter:loadingView.center];
        //        [activityView startAnimating];
        //        [loadingView addSubview:activityView];
        
        
        UIImageView* cabImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wobbleCab.png"]];
        [cabImageView setCenter:loadingView.center];
        [loadingView addSubview:cabImageView];
        
        cabImageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-5));
        
        [UIView animateWithDuration:0.15
                              delay:0.0
                            options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse)
                         animations:^ {
                             cabImageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(5));
                         }
                         completion:NULL
         ];
        
        
        
        [loadingView setFrame:CGRectMake(self.window.frame.origin.x, self.window.frame.size.height, self.window.frame.size.width, self.window.frame.size.height)];
    }
    [self.window bringSubviewToFront:loadingView];
    
    
    [UIView animateWithDuration:0.5f animations:^{
        [loadingView setFrame:CGRectMake(self.window.frame.origin.x, self.window.frame.origin.y, self.window.frame.size.width, self.window.frame.size.height)];
    }];
    
    
}

-(void) hideLoadingBar
{
    [UIView animateWithDuration:0.5f animations:^{
        [loadingView setFrame:CGRectMake(self.window.frame.origin.x, self.window.frame.size.height, self.window.frame.size.width, self.window.frame.size.height)];
    }];
    
}

@end
