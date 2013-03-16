//
//  GDIP - AppDelegate.m
//
//  Created by Phaedra Deepsky on 2012-11-24.

#import "AppDelegate.h"
#import "VWTAnimatedView.h"
#import "VWTExternalAddressProcessor.h"
#import "VWTUserDefaultsManager.h"

@interface AppDelegate() <NSPopoverDelegate, VWTAnimatedViewDelegate,VWTExternalAddressProcessorDelegate>

@property (nonatomic) NSStatusItem *statusItem;
@property (nonatomic) VWTExternalAddressProcessor *addressProccessor;
@property (nonatomic) VWTUserDefaultsManager *defaultsManager;

@end

typedef enum ViewName : int {
	externalIPAddressView,
	externalHostNameView,
	localIPAddressView,
	localHostNameView
	
} ViewName;

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
	[self.externalIPAddressView setDelegate:self];
	[self.externalIPAddressView drawText:[self.addressesAndHostsForViews valueForKey:@"externalIPAddress"] withSlideInAnimation:YES forView:externalIPAddressView];
	}

- (void)showPopover:(id)sender
{
	_addressProccessor = [[VWTExternalAddressProcessor alloc]init];
	[self.addressProccessor setDelegate:self];
	[_popover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMinYEdge];
	[self.popover setDelegate:self];
}

- (void)animationDidCompleteForView:(int)viewName
{
		switch (viewName) {
		case externalIPAddressView:
			[self.externalHostNameView drawText:[self.addressesAndHostsForViews valueForKey:@"externalHostName"] withSlideInAnimation:YES forView:externalHostNameView];
			[self.externalHostNameView setDelegate:self];
			break;
		case externalHostNameView:
			[self.localIPAddressView drawText:[self.addressesAndHostsForViews valueForKey:@"localIPAddress"] withSlideInAnimation:YES forView:localIPAddressView];
			[self.localIPAddressView setDelegate:self];
			break;
		case localIPAddressView:
			[self.localHostNameView drawText:[self.addressesAndHostsForViews valueForKey:@"localHostName"] withSlideInAnimation:YES forView:localHostNameView];
			break;
		default:
			break;
	}
}

-(void)popoverDidClose:(NSNotification *)notification
{
	[self.externalIPAddressView drawText:@"" withSlideInAnimation:NO forView:externalIPAddressView];
	[self.externalHostNameView drawText:@"" withSlideInAnimation:NO forView:externalHostNameView];
	[self.localIPAddressView drawText:@"" withSlideInAnimation:NO forView:localIPAddressView];
	[self.localHostNameView drawText:@"" withSlideInAnimation:NO forView:localHostNameView];
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