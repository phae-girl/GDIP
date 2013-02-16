//
//  GDIP - AppDelegate.m
//
//  Created by Phaedra Deepsky on 2012-11-24.


#import "AppDelegate.h"


@implementation AppDelegate
{
	NSStatusItem *statusItem;
	VWTExternalAddressProcessor *addressProccessor;
}

@synthesize popover = _popover;

- (void)popoverDidClose:(NSNotification *)notification
{
	self.hostName = nil;
	self.ipAddress = nil;
}

- (void)awakeFromNib
{
	statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	[statusItem setToolTip:@"Show My IP"];
	[statusItem setImage:[NSImage imageNamed:@"statusBarGreen"]];
	[statusItem setHighlightMode:YES];
	[statusItem setAction:@selector(showPopover:)];
}

-(void)ipAndHostWereSet
{
	self.ipAddress = [addressProccessor.addressAndHostName valueForKey:@"address"];
	self.hostName = [addressProccessor.addressAndHostName valueForKey:@"hostname"];
}

- (void)showPopover:(id)sender
{
	addressProccessor = [[VWTExternalAddressProcessor alloc]init];
	[addressProccessor setDelegate:self];
	[addressProccessor retrieveIPAndHost];

	[_popover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMaxYEdge];
}

- (NSWindow *)detachableWindowForPopover:(NSPopover *)popover {
	return _tearOffWindow;
}

- (IBAction)windowQuit:(id)sender {
	[NSApp terminate:nil];
}

- (IBAction)popoverQuit:(id)sender {
	[NSApp terminate:nil];
}


@end
