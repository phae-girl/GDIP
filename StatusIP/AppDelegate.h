//
//  VWTAppDelegate.h
//  StatusIP
//
//  Created by Phaedra Deepsky on 2012-11-24.
//  Copyright (c) 2012 Phaedra Deepsky. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSPopoverDelegate> {
	
	
}


@property (weak) IBOutlet NSPopover *popover;

//@property NSString *ipAddress, *hostName;

- (IBAction)showPopover:(id)sender;
- (IBAction)windowQuit:(id)sender;
- (IBAction)popoverQuit:(id)sender;



@end
