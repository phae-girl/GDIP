//
//  GDIP - AppDelegate.h
//
//  Created by Phaedra Deepsky on 2012-11-24.


#import <Cocoa/Cocoa.h>
#import "VWTExternalAddressProcessor.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet NSPopover *popover;
@property (unsafe_unretained) IBOutlet NSWindow *tearOffWindow;

@property NSMutableDictionary *myDictionary;

- (IBAction)windowQuit:(id)sender;
- (IBAction)popoverQuit:(id)sender;

@end