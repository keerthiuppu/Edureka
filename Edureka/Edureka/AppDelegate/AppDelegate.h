//
//  AppDelegate.h
//  Edureka
//
//  Created by Neeraj Sharma on 17/03/15.
//  Copyright (c) 2015 KelltonTech Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{

}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

-(void) configureTabBar;

-(void) showLoadingBar;
-(void) hideLoadingBar;

@end

