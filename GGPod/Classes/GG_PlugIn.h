//
//  Google.h
//  Emozik
//
//  Created by Thanh Hai Tran on 11/23/16.
//  Copyright © 2016 Thanh Hai Tran. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GoogleSignIn/GoogleSignIn.h"

typedef void (^GGCompletion)(NSString * responseString, id object, int errorCode, NSString *description, NSError * error);

@interface GG_PlugIn : NSObject<GIDSignInDelegate, GIDSignInUIDelegate>

+ (GG_PlugIn*)shareInstance;

- (void)startLogGoogleWithCompletion:(GGCompletion)comp andHost:(UIViewController*)host_;

- (void)signOutGoogle;

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end
