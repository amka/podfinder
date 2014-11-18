//
//  AppDelegate.h
//  Podfinder
//
//  Created by Andrey M on 17.11.14.
//  Copyright (c) 2014 Andrey M. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSString *_osFilter;
}

@property (weak) IBOutlet NSSegmentedControl *osSelector;
@property (weak) IBOutlet NSArrayController *foundPodsController;
@property (weak) IBOutlet NSSearchField *searchField;
@property (weak) IBOutlet NSWindow *window;

- (IBAction)searchFieldChanged:(id)sender;
- (IBAction)osSelectorChanged:(id)sender;

@end

