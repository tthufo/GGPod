//
//  GGViewController.m
//  GGPod
//
//  Created by tthufo@gmail.com on 07/09/2018.
//  Copyright (c) 2018 tthufo@gmail.com. All rights reserved.
//

#import "GGViewController.h"

#import "GG_PlugIn.h"

@interface GGViewController ()

@end

@implementation GGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (IBAction)didPress:(id)sender {
    [[GG_PlugIn shareInstance] startLogGoogleWithCompletion:^(NSString *responseString, id object, int errorCode, NSString *description, NSError *error) {
        
        if(!object)
        {
            return ;
        }
        
        NSLog(@"%@", object);
        
    } andHost:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
