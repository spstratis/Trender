//
//  TRAppDelegate.m
//  Trender
//
//  Created by Michael Reneer on 7/3/12.
//  Copyright (c) 2012 Trender. All rights reserved.
//

#import <Twitter/Twitter.h>
#import "TRAppDelegate.h"

#pragma mark - Implementation

@implementation TRAppDelegate

#pragma mark - Instance Properties

@synthesize window;

#pragma mark - Protocol Methods - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@"#obama" forKey:@"q"];
    [parameters setObject:@"100" forKey:@"rpp"];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://search.twitter.com/search.json"];
    
    TWRequestHandler handler = ^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if (responseData) {
            NSError *error;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
            
            if (error == nil) {
                
                for (NSDictionary *tweet in [response objectForKey:@"results"]) {
                    NSLog(@"%@", [tweet objectForKey:@"created_at"]);
                }
            } 
            else { 
                NSLog(@"%@", error);
            }
        }
    };
    
    TWRequest *request = [[TWRequest alloc] initWithURL:url parameters:parameters requestMethod:TWRequestMethodGET];
    [request performRequestWithHandler:handler];
    
    return YES;
}

@end
