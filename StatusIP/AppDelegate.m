//
//  GDIP - AppDelegate.m
//
//  Created by Phaedra Deepsky on 2012-11-24.

#import "AppDelegate.h"
#import "VWTExternalAddressProcessor.h"
#import "VWTUserDefaultsManager.h"
#import "NSArray+Iterator.h"

@interface AppDelegate() <NSPopoverDelegate, VWTExternalAddressProcessorDelegate>
@property (nonatomic) NSStatusItem *statusItem;
@property (nonatomic) VWTExternalAddressProcessor *addressProccessor;
@property (nonatomic) VWTUserDefaultsManager *defaultsManager;
@property (nonatomic) NSArray *addressLabels;
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
	_addressLabels = @[self.externalIPAddressLabel, self.externalHostNameLabel, self.localIPAddressLabel, self.localHostNameLabel];
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
	[self.addressLabels each:^(NSTextField *label){[label setFrameOrigin:NSMakePoint(-label.frame.size.width, label.frame.origin.y)];}];
}

- (void)slideInAddressAndHostLabels
{
	[NSAnimationContext beginGrouping];
	[[NSAnimationContext currentContext] setDuration:0.5f];
	[self.addressLabels each:^(NSTextField *label){[[label animator] setFrameOrigin:NSMakePoint(0, label.frame.origin.y)];}];
	[NSAnimationContext endGrouping];
}

- (IBAction)copyAddressesAndHostsToPasteboard:(id)sender{
	
	NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
	NSMutableArray *preCopyArray = [NSMutableArray array];
	NSDictionary *copyableItems = [NSDictionary dictionaryWithDictionary:[self.defaultsManager checkCopyableItems]];
	if ([copyableItems[@"externalIPAddressIsCopyable"] boolValue]) {
		[preCopyArray addObject:self.addressesAndHostsForViews[@"externalIPAddress"]];
	}
	if ([copyableItems[@"externalHostNameIsCopyable"] boolValue]) {
		[preCopyArray addObject:self.addressesAndHostsForViews[@"externalHostName"]];
	}
	if ([copyableItems[@"localIPAddressIsCopyable"] boolValue]) {
		[preCopyArray addObject:self.addressesAndHostsForViews[@"localIPAddress"]];
	}
	if ([copyableItems[@"localHostNameIsCopyable"] boolValue]) {
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