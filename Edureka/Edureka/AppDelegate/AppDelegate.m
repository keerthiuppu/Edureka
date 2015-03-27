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
#import "EDForumVC.h"
#import "EDMoreVC.h"


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
    EDTicketVC* edTicketVC = [[EDTicketVC alloc] initWithNibName:@"EDTicketVC" bundle:nil];
    EDForumVC* edForumVC = [[EDForumVC alloc] initWithNibName:@"EDForumVC" bundle:nil];
    EDMoreVC* edMoreVC = [[EDMoreVC alloc] initWithNibName:@"EDMoreVC" bundle:nil];
    
    edHomeVC.title = @"Home";
    edHomeVC.tabBarItem.image = [UIImage imageNamed:@"home"];
    
    edMyCourseVC.title=@"My Courses";
    edMyCourseVC.tabBarItem.image = [UIImage imageNamed:@"myCourse"];
    
    edTicketVC.title = @"Tickets";
    edTicketVC.tabBarItem.image = [UIImage imageNamed:@"ticket"];

    edForumVC.title= @"Forum";
    edForumVC.tabBarItem.image = [UIImage imageNamed:@"forum"];

    edMoreVC.title = @"More";
    edMoreVC.tabBarItem.image = [UIImage imageNamed:@"more"];

    UINavigationController* homeNavControl =[[UINavigationController alloc] initWithRootViewController:edHomeVC];
    UINavigationController* myCourseNavControl =[[UINavigationController alloc] initWithRootViewController:edMyCourseVC];
    UINavigationController* ticketNavControl =[[UINavigationController alloc] initWithRootViewController:edTicketVC];
    UINavigationController* forumNavControl =[[UINavigationController alloc] initWithRootViewController:edForumVC];
    UINavigationController* moreNavControl =[[UINavigationController alloc] initWithRootViewController:edMoreVC];
    
    
    //create an array of all view controllers that will represent the tab at the bottom
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:homeNavControl, myCourseNavControl,ticketNavControl,forumNavControl, moreNavControl, nil];
    //initialize the tab bar controller
    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController setViewControllers:viewControllers];
    [self.window addSubview:self.tabBarController.view];
}

#pragma mark - Loader
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
