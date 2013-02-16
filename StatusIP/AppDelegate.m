//
//  VWTAppDelegate.m
//  StatusIP
//
//  Created by Phaedra Deepsky on 2012-11-24.
//  Copyright (c) 2012 Phaedra Deepsky. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate
{
	NSStatusItem *statusItem;
	NSAlert *alert;
	VWTExternalAddressProcessor *statusIPModel;
}

@synthesize popover = _popover;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
	
}

- (void)popoverWillShow:(NSNotification *)notification
{

}

- (void)popoverDidClose:(NSNotification *)notification
{
	self.hostName = nil;
	self.ipAddress = nil;
}

- (void)awakeFromNib
{
	statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	[statusItem setToolTip:@"Show My IP"];
	[statusItem setImage:[NSImage imageNamed:@"network"]];
	[statusItem setHighlightMode:YES];
	[statusItem setAction:@selector(prepareToShowPopover:)];
}

- (void)prepareToShowPopover:(id)sender
{
	statusIPModel = [[VWTExternalAddressProcessor alloc]init];
	[statusIPModel setDelegate:self];
	[statusIPModel loadThePage];
	[self showPopover:sender];
}

-(void)ipAndHostDidGetSet
{
	NSLog(@"We Did Something Delegated!");
	NSLog(@"%@", statusIPModel.addressAndHostName);
	self.ipAddress = [statusIPModel.addressAndHostName valueForKey: @"address"];
	self.hostName = [statusIPModel.addressAndHostName valueForKey:@"hostname"];
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
