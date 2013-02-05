//
//  VWTAppDelegate.m
//  StatusIP
//
//  Created by Phaedra Deepsky on 2012-11-24.
//  Copyright (c) 2012 Phaedra Deepsky. All rights reserved.
//

#import "AppDelegate.h"
//#import "IPHandler.h"
#import "TestClass.h"

@implementation AppDelegate {
	NSStatusItem *statusItem;
	NSAlert *alert;
	//IPHandler *ipHandler;
	TestClass *testClass;
}

//@synthesize ipAddress, hostName;
@synthesize popover = _popover;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	//ipHandler = [[IPHandler alloc]init];
	
	
}

- (void)applicationWillTerminate:(NSNotification *)notification {
	
}

- (void)popoverWillShow:(NSNotification *)notification
{
	//self.ipAddress = [self checkIP];
	//self.hostName = [self getHostName];
}

- (void)awakeFromNib
{
	statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	[statusItem setToolTip:@"Show My IP"];
	[statusItem setImage:[NSImage imageNamed:@"network"]];
	[statusItem setHighlightMode:YES];
	//[statusItem setTarget:ipHandler];
	[statusItem setAction:@selector(prepareToShowPopover:)];
}

- (void)prepareToShowPopover:(id)sender
{
	testClass = [[TestClass alloc]init];
	[testClass loadThePage];
	//[testClass getIPAndHost];
}


- (IBAction)showPopover:(id)sender
{
	[_popover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMaxYEdge];
}

- (IBAction)windowQuit:(id)sender {
	[NSApp terminate:nil];
}

- (IBAction)popoverQuit:(id)sender {
	[NSApp terminate:nil];
}


@end
