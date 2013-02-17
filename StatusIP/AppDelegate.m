//
//  GDIP - AppDelegate.m
//
//  Created by Phaedra Deepsky on 2012-11-24.


#import "AppDelegate.h"
#import "VWTUserDefaultsManager.h"

@interface AppDelegate() <VWTExternalAddressProcessorDelegate, NSPopoverDelegate>
@property VWTUserDefaultsManager *defaultsManager;

@end

@implementation AppDelegate
{
	NSStatusItem *statusItem;
	VWTExternalAddressProcessor *addressProccessor;
}

- (id)init
{
    self = [super init];
    if (self) {
        _defaultsManager = [[VWTUserDefaultsManager alloc]init];
    }
    return self;
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
	self.viewDynamicDataItems = [NSMutableDictionary dictionaryWithDictionary:addressesAndHosts];
	[self.viewDynamicDataItems setValue:[[NSArray arrayWithObjects:@"Hosts and IP Addresses for",[addressesAndHosts valueForKey:@"localizedName"], nil] componentsJoinedByString:@" " ] forKey:@"tearoffTitle"];
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

- (IBAction)copyExternalIPToPasteboard:(id)sender{
	
	NSPasteboard *pb = [NSPasteboard generalPasteboard];
	[pb clearContents];
	[pb writeObjects:[NSArray arrayWithObjects:[self.viewDynamicDataItems valueForKey:@"externalAddress"], nil]];
	
}



@end
