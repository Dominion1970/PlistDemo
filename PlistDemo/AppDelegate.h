//
//  AppDelegate.h
//  PlistDemo
//
//  Created by Valentine Gorshkov on 15.11.12.
//  Copyright (c) 2012 silvansky. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

- (IBAction)savePlist:(id)sender;
- (IBAction)loadPlist:(id)sender;

@end
