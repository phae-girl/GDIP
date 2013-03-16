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
	[self hideAddressAndHostLabels];
}

- (void)showPopover:(id)sender
{
	_addressProccessor = [[VWTExternalAddressProcessor alloc]init];
	[self.addressProccessor setDelegate:self];
	[_popover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMinYEdge];
	[self.popover setDelegate:self];
}

- (void)popoverDidShow:(NSNotification *)notification
{
	[self slideInAddressAndHostLabels];
}
- (IBAction)quitApp:(id)sender {
	[NSApp terminate:nil];
}

- (void)hideAddressAndHostLabels
{
	[self.externalIPAddressLabel setFrameOrigin:NSMakePoint(-self.externalIPAddressLabel.frame.size.width, self.externalIPAddressLabel.frame.origin.y)];
	[self.externalHostNameLabel setFrameOrigin:NSMakePoint(-self.externalHostNameLabel.frame.size.width, self.externalHostNameLabel.frame.origin.y)];
	[self.localIPAddressLabel setFrameOrigin:NSMakePoint(-self.localIPAddressLabel.frame.size.width, self.localIPAddressLabel.frame.origin.y)];
	[self.localHostNameLabel setFrameOrigin:NSMakePoint(-self.localHostNameLabel.frame.size.width, self.localHostNameLabel.frame.origin.y)];

}

- (void)slideInAddressAndHostLabels
{
	[NSAnimationContext beginGrouping];
	[[NSAnimationContext currentContext] setDuration:0.5f];
	[[self.externalIPAddressLabel animator] setFrameOrigin:NSMakePoint(0, self.externalIPAddressLabel.frame.origin.y)];
	[[self.externalHostNameLabel animator ] setFrameOrigin:NSMakePoint(0, self.externalHostNameLabel.frame.origin.y)];
	[[self.localIPAddressLabel animator] setFrameOrigin:NSMakePoint(0, self.localIPAddressLabel.frame.origin.y)];
	[[self.localHostNameLabel animator] setFrameOrigin:NSMakePoint(0, self.localHostNameLabel.frame.origin.y)];
	[NSAnimationContext endGrouping];
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
	[self hideAddressAndHostLabels];
	//TODO: Implement Refresh System
	[self slideInAddressAndHostLabels];
}

- (IBAction)showPreferences:(id)sender
{
	//TODO: Set up Preferences Panel
}
@end