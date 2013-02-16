//
//  GDIP - AppDelegate.m
//
//  Created by Phaedra Deepsky on 2012-11-24.


#import "AppDelegate.h"

@interface AppDelegate() <VWTExternalAddressProcessorDelegate, NSPopoverDelegate>

@end

@implementation AppDelegate
{
	NSStatusItem *statusItem;
	VWTExternalAddressProcessor *addressProccessor;
}


- (void)awakeFromNib
{
	statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	[statusItem setToolTip:@"Show My IP"];
	[statusItem setImage:[NSImage imageNamed:@"statusBarGreen"]];
	[statusItem setHighlightMode:YES];
	[statusItem setAction:@selector(showPopover:)];
}

- (void)processorDidRetriveAddressesAndHosts:(NSDictionary *)addressesAndHosts
{
	self.myDictionary = [NSMutableDictionary dictionaryWithDictionary:addressesAndHosts];
	[self.myDictionary setValue:[[NSArray arrayWithObjects:@"Hosts and IP Addresses for",[addressesAndHosts valueForKey:@"localizedName"], nil] componentsJoinedByString:@" " ] forKey:@"tearoffTitle"];
}

- (void)willSetValue: (NSString*)aString {
	NSLog(@"This is the string:%@", aString);
}

- (void)showPopover:(id)sender
{
	addressProccessor = [[VWTExternalAddressProcessor alloc]init];
	[addressProccessor setDelegate:self];
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
