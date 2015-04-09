//
//  KelltonSettings.m
//  GroupOnGo
//
//  Created by Neeraj Sharma on 6/16/14.
//  Copyright (c) 2014 Neeraj Sharma. All rights reserved.
//


#import "KelltonSettings.h"
#define LAST_CONF_KEY   @"lastClientServiceConfiguration"


const NSString *ProductionServerKelltonServiceURL  =  @"https://dev.edurekaglobal.com/api/1.0/";//@"Your production server url";
const NSString *QAServerKelltonServiceURL = @"https://dev.edurekaglobal.com/api/1.0/";//@"Your QA server url";
const NSString *DevelopmentServerKelltonServiceURL = @"https://dev.edurekaglobal.com/api/1.0/";//@"Your development server"


static KelltonSettings *_KelltonSettings = nil;

@interface KelltonSettings ()

@property (nonatomic, copy) NSURL *clientServiceURL;
- (KelltonServerType)serverTypeWithString:(NSString *)serverTypeString;

- (void)cleanDataBase;

@end

@implementation KelltonSettings

@synthesize clientServiceURL;

- (id)init {
    self = [super init];
    if (self) {
        [self updateSettings];
    }
    return self;
}

- (KelltonServerType)serverTypeWithString:(NSString *)serverTypeString {
    if ([serverTypeString length])
    {
        return (KelltonServerType)[serverTypeString characterAtIndex:0];
    }
    return KelltonServerTypeDevlopment;
}

- (void)cleanDataBase
{
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    
    NSFileManager *fileMgr = [[NSFileManager alloc] init];
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSArray *files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
    
    while (files.count > 0) {
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSArray *directoryContents = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error];
        if (error == nil) {
            for (NSString *path in directoryContents) {
                NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:path];
                BOOL removeSuccess = [fileMgr removeItemAtPath:fullPath error:&error];
                files = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:nil];
                if (!removeSuccess) {
                    // Error
                }
            }
        } else {
            // Error
        }
    }
    
    
}

- (void)updateSettings {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults synchronize];
    
    //  update clientService URL
    KelltonServerType clientServiceServerType = [self serverTypeWithString:[userDefaults objectForKey:@"clientServiceServer"]];
    NSString *clientServiceURLString = nil;
    switch (clientServiceServerType) {
        case KelltonServerTypeProduction:
            clientServiceURLString = (NSString *)ProductionServerKelltonServiceURL;
            break;
        case KelltonServerTypeDevlopment:
            clientServiceURLString = (NSString*)DevelopmentServerKelltonServiceURL;
            break;
        case KelltonServerTypeQA:
            clientServiceURLString = (NSString*) QAServerKelltonServiceURL;
            break;
    }
    self.clientServiceURL = [NSURL URLWithString:clientServiceURLString];
    if (![[self.clientServiceURL absoluteString] isEqualToString:[userDefaults objectForKey:LAST_CONF_KEY]]) {
        // current configuration is different that the last configuration
        // so we should clean the database because data may defer
        [self cleanDataBase];
        // and save the last configuration, so we do not clean the data base next time
        [userDefaults setObject:[self.clientServiceURL absoluteString] forKey:LAST_CONF_KEY];
        [userDefaults synchronize];
    }
}

#pragma mark - Class methods

+ (KelltonSettings *)sharedInstance {
    if (!_KelltonSettings) {
        _KelltonSettings = [[self alloc] init];
    }
    return _KelltonSettings;
}

+ (NSURL *)clientServiceURL {
    return [self sharedInstance].clientServiceURL;
}




@end