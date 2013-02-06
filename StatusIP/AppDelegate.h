//
//  VWTAppDelegate.h
//  StatusIP
//
//  Created by Phaedra Deepsky on 2012-11-24.
//  Copyright (c) 2012 Phaedra Deepsky. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "TestClass.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSPopoverDelegate, TestClassDelegate>

@property (weak) IBOutlet NSPopover *popover;

@property (weak) NSString *hostName, *ipAddress;

- (IBAction)showPopover:(id)sender;
- (IBAction)windowQuit:(id)sender;
- (IBAction)popoverQuit:(id)sender;
- (void)ipAndHostDidGetSet;
@end