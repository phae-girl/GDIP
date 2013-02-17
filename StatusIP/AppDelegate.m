//
//  GDIP - AppDelegate.m
//
//  Created by Phaedra Deepsky on 2012-11-24.


#import "AppDelegate.h"
#import "VWTUserDefaultsManager.h"

@interface AppDelegate() <VWTExternalAddressProcessorDelegate, NSPopoverDelegate>
@property (nonatomic) VWTUserDefaultsManager *defaultsManager;
@property (nonatomic) NSStatusItem *statusItem;
@property (nonatomic) VWTExternalAddressProcessor *addressProccessor;

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
	self.viewDynamicDataItems = [NSMutableDictionary dictionaryWithDictionary:addressesAndHosts];
	[self.viewDynamicDataItems setValue:[[NSArray arrayWithObjects:@"Hosts and IP Addresses for",[addressesAndHosts valueForKey:@"localizedName"], nil] componentsJoinedByString:@" " ] forKey:@"tearoffTitle"];
}


- (void)showPopover:(id)sender
{
	if ([self.tearOffWindow isVisible]) {
		return;
	}
	_addressProccessor = [[VWTExternalAddressProcessor alloc]init];
	[self.addressProccessor setDelegate:self];
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
	
	NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
	NSMutableArray *preCopyArray = [NSMutableArray array];
	NSDictionary *copyableItems = [NSDictionary dictionaryWithDictionary:[self.defaultsManager checkCopyableItems]];
	if (copyableItems[@"externalIP"]) {
		[preCopyArray addObject:self.viewDynamicDataItems[@"externalAddress"]];
	}
	if (copyableItems[@"externalHost"]) {
		[preCopyArray addObject:self.viewDynamicDataItems[@"externalHostName"]];
	}
	if (copyableItems[@"localIP"]) {
		[preCopyArray addObject:self.viewDynamicDataItems[@"localAddress"]];
	}
	if (copyableItems[@"localHost"]) {
		[preCopyArray addObject:self.viewDynamicDataItems[@"localHostName"]];
	}
	
	[pasteboard clearContents];
	[pasteboard writeObjects:@[[preCopyArray componentsJoinedByString:@"\n"]]];
	
}



@end
