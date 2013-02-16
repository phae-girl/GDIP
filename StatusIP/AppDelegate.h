//
//  StatusIP
//
//  Created by Phaedra Deepsky on 2012-11-24.


#import <Cocoa/Cocoa.h>
#import "VWTExternalAddressProcessor.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSPopoverDelegate, VWTExternalAddressProcessorDelegate>

@property (weak) IBOutlet NSPopover *popover;

@property (weak) NSString *hostName, *ipAddress;

- (IBAction)showPopover:(id)sender;
- (IBAction)windowQuit:(id)sender;
- (IBAction)popoverQuit:(id)sender;
- (void)ipAndHostWereSet;
@end