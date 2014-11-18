//
//  AppDelegate.m
//  Podfinder
//
//  Created by Andrey M on 17.11.14.
//  Copyright (c) 2014 Andrey M. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.window.titleVisibility = NSWindowTitleHidden;
    
    switch (self.osSelector.selectedSegment) {
        case 0:
            NSLog(@"OSX Pods");
            _osFilter = @"osx";
            break;
        case 1:
            NSLog(@"iOS Pods");
            _osFilter = @"ios";
            break;
            
        default:
            NSLog(@"Any Pods");
            _osFilter = @"";
            break;
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)searchPod:(NSString *)query forOS:(NSString *)os {
    if (query.length)
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        if (os.length) {
            query = [NSString stringWithFormat:@"on:%@ %@", os, query];
        }
        NSLog(@"Query: %@", query);
        
        [manager GET:@"http://search.cocoapods.org/api/v1/pods.flat.hash.json"
          parameters:@{@"query":query}
             success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             if ([responseObject isKindOfClass:[NSArray class]])
             {
                 self.foundPodsController.content = responseObject;
                 NSLog (@"%@", responseObject);
             }
             else
             {
                 self.foundPodsController.content = [NSArray array];;
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             self.foundPodsController.content = [NSArray array];;
         }];
    }
    else
    {
        self.foundPodsController.content = [NSArray array];
    }
}

- (IBAction)searchFieldChanged:(id)sender {
    [self searchPod:self.searchField.stringValue forOS:_osFilter];
}

- (IBAction)osSelectorChanged:(id)sender {
    switch (self.osSelector.selectedSegment) {
        case 0:
            NSLog(@"OSX Pods");
            _osFilter = @"osx";
            break;
        case 1:
            NSLog(@"iOS Pods");
            _osFilter = @"ios";
            break;
            
        default:
            NSLog(@"Any Pods");
            _osFilter = @"";
            break;
    }
    
    [self searchPod:self.searchField.stringValue forOS:_osFilter];
}
@end
