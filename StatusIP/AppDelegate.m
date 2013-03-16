//
//  GDIP - AppDelegate.m
//
//  Created by Phaedra Deepsky on 2012-11-24.

#import "AppDelegate.h"
#import "VWTExternalAddressProcessor.h"
#import "VWTUserDefaultsManager.h"

@interface AppDelegate() <NSPopoverDelegate, VWTExternalAddressProcessorDelegate>
@property (nonatomic) NSStatusItem *statusItem;
@property (nonatomic) VWTExternalAddressProcessor *addressProccessor;
@property (nonatomic) VWTUserDefaultsManager *defaultsManager;

@end


@implementation AppDelegate

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
	_statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	[self.statusItem setToolTip:@"Show My IP"];
	[self.statusItem setImage:[NSImage imageNamed:@"statusBarGreen"]];
	[self.statusItem setHighlightMode:YES];
	[self.statusItem setAction:@selector(showPopover:)];
}

- (void)processorDidRetriveAddressesAndHosts:(NSDictionary *)addressesAndHosts
{
	self.addressesAndHostsForViews = [NSMutableDictionary dictionaryWithDictionary:addressesAndHosts];
//	[self.externalIPAddressView setDelegate:self];
//	[self.externalIPAddressView drawText:[self.addressesAndHostsForViews valueForKey:@"externalIPAddress"] withSlideInAnimation:YES forView:externalIPAddressView];
	}

- (void)showPopover:(id)sender
{
	_addressProccessor = [[VWTExternalAddressProcessor alloc]init];
	[self.addressProccessor setDelegate:self];
	[_popover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMinYEdge];
	[self.popover setDelegate:self];
}

- (IBAction)quitApp:(id)sender {
	[NSApp terminate:nil];
}

- (IBAction)copyAddressesAndHostsToPasteboard:(id)sender{
	
	NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
	NSMutableArray *preCopyArray = [NSMutableArray array];
	NSDictionary *copyableItems = [NSDictionary dictionaryWithDictionary:[self.defaultsManager checkCopyableItems]];
	if (copyableItems[@"externalIPAddressIsCopyable"]) {
		[preCopyArray addObject:self.addressesAndHostsForViews[@"externalIPAddress"]];
	}
	if (copyableItems[@"externalHostNameIsCopyable"]) {
		[preCopyArray addObject:self.addressesAndHostsForViews[@"externalHostName"]];
	}
	if (copyableItems[@"localIPAddressIsCopyable"]) {
		[preCopyArray addObject:self.addressesAndHostsForViews[@"localIPAddress"]];
	}
	if (copyableItems[@"localHostNameIsCopyable"]) {
		[preCopyArray addObject:self.addressesAndHostsForViews[@"localHostName"]];
	}
	
	[pasteboard clearContents];
	[pasteboard writeObjects:@[[preCopyArray componentsJoinedByString:@"\n"]]];
}

- (IBAction)refreshData:(id)sender {
	//TODO: Implement Refresh System
}

- (IBAction)showPreferences:(id)sender
{
	//TODO: Set up Preferences Panel
}
@end