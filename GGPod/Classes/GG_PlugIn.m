//
//  Google.m
//  Emozik
//
//  Created by Thanh Hai Tran on 11/23/16.
//  Copyright © 2016 Thanh Hai Tran. All rights reserved.
//

#import "GG_PlugIn.h"

#import "SVProgressHUD.h"

static GG_PlugIn * shareGoogle = nil;

@implementation GG_PlugIn
{
    GGCompletion completionBlock;
    
    UIViewController * host;
}

+ (GG_PlugIn*)shareInstance
{
    if(!shareGoogle)
    {
        shareGoogle = [GG_PlugIn new];
    }
    return shareGoogle;
}

- (void)startLogGoogleWithCompletion:(GGCompletion)comp andHost:(UIViewController*)host_
{
    if(host_)
    {
//        [self showLoading];

        host = host_;
    }
    
    completionBlock = comp;
    
    [GIDSignIn sharedInstance].delegate = self;
    
    [GIDSignIn sharedInstance].presentingViewController = host;

    [GIDSignIn sharedInstance].shouldFetchBasicProfile = YES;
    
    [[GIDSignIn sharedInstance] signIn];
}

- (void)signOutGoogle
{
    [[GIDSignIn sharedInstance] signOut];
}

#pragma mark Logic

- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *gPlist = [[NSBundle mainBundle] pathForResource:@"GoogleService-Info" ofType:@"plist"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:gPlist];
    
    
    if (!dictionary[@"CLIENT_ID"])
    {
        NSLog(@"Check your GoogleService-Info.plist is not right path or name");
    }
    else
    {
        [GIDSignIn sharedInstance].clientID = dictionary[@"CLIENT_ID"];
    }
    
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    
    NSDictionary *pList = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if(!pList)
    {
        NSLog(@"Check your Info.plist is not right path or name");
    }
    
    
    if (dictionary[@"REVERSED_CLIENT_ID"])
    {
        BOOL found = NO;
        NSString *appID = [NSString stringWithFormat:@"%@", dictionary[@"REVERSED_CLIENT_ID"]];
        if (pList[@"CFBundleURLTypes"])
        {
            for (NSDictionary *item in pList[@"CFBundleURLTypes"])
            {
                if (item[@"CFBundleURLSchemes"])
                {
                    for (NSString *scheme in item[@"CFBundleURLSchemes"])
                    {
                        if ([scheme isEqualToString:appID])
                        {
                            found = YES;
                            break;
                        }
                    }
                }
            }
        }
        if (!found)
        {
            NSLog(@"Please setup URL types in Plist as %@", appID);
        }
    }
}


- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    if(user)
    {
        NSString * urlImage;
        
        if (signIn.currentUser.profile.hasImage)
        {
            NSUInteger dimension = round(150 * [[UIScreen mainScreen] scale]);
            
            NSURL *imageURL = [user.profile imageURLWithDimension:dimension];
            
            urlImage = [imageURL absoluteString];
        }
        
        completionBlock(@"ok",@{@"uId":user.userID, @"fullName":user.profile.name, @"email":user.profile.email,@"avatar":urlImage} , 0, nil, error);
    }
    else
    {
        completionBlock(nil, nil, -1, error.localizedDescription, error);
    }
    
//    [SVProgressHUD dismiss];
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    
}

#pragma mark UI

- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error
{

}

- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController
{
    [host presentViewController:viewController animated:YES completion:nil];
}

- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController
{
    [host dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    [self showLoading];
    
    return [[GIDSignIn sharedInstance] handleURL:url];// sourceApplication:sourceApplication annotation:annotation];
}

- (void)showLoading
{
    [SVProgressHUD showWithStatus:@"Đang tải"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setBackgroundColor:[UIColor orangeColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
}


@end
