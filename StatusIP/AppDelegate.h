//
//  GDIP - AppDelegate.h
//
//  Created by Phaedra Deepsky on 2012-11-24.


#import <Cocoa/Cocoa.h>

@class VWTAnimatedView;
@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet NSPopover *popover;
@property (weak) IBOutlet NSTextField *externalIPAddressLabel, *externalHostNameLabel, *localIPAddressLabel, *localHostNameLabel;
@property (weak) IBOutlet NSView *externalIPAddressView, *externalHostNameView, *localIPAddressView, *localHostNameView;

- (IBAction)copyAddressesAndHostsToPasteboard:(id)sender;
- (IBAction)quitApp:(id)sender;
- (IBAction)refreshData:(id)sender;
- (IBAction)showPreferences:(id)sender;

@end