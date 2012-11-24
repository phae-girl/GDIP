//
//  VWTAppDelegate.m
//  StatusIP
//
//  Created by Phaedra Deepsky on 2012-11-24.
//  Copyright (c) 2012 Phaedra Deepsky. All rights reserved.
//

#import "VWTAppDelegate.h"

@implementation VWTAppDelegate

@synthesize ipAddress, hostName;
@synthesize popover = _popover;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	
}

- (void)applicationWillTerminate:(NSNotification *)notification {
	
}

- (void)awakeFromNib {
	self.ipAddress = [self checkIP];
	self.hostName = [self getHostName];
	
	statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	[statusItem setToolTip:@"Show My IP"];
	//[statusItem setTitle:ipAddress];
	[statusItem setImage:[NSImage imageNamed:@"network"]];
	[statusItem setHighlightMode:YES];
	[statusItem setAction:@selector(showPopover:)];
	
	
}

- (NSString *)checkIP {
	NSString *theIP = [NSString string];
	
	NSError *error = nil;
	NSMutableArray *arrayOfMatchStrings = [NSMutableArray array];
	
	NSURL *theURL = [NSURL URLWithString:@"http://checkip.dyndns.com/"];
	NSString *thePage = [NSString stringWithContentsOfURL:theURL
												 encoding:NSUTF8StringEncoding
													error:&error];
	if (!error) {
		// The NSRegularExpression class is currently only available in the Foundation framework of iOS 4
		NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\d{1,3}.\\d{1,3}.\\d{1,3}.\\d{1,3}"
																			   options:NSRegularExpressionDotMatchesLineSeparators | NSRegularExpressionAnchorsMatchLines
																				 error:&error];
		
		NSArray *matchArray = [regex matchesInString:thePage options:0 range:NSMakeRange(0, [thePage length])];
		
		for (NSTextCheckingResult *match in matchArray) {
			NSString *substringForMatch = [thePage substringWithRange:match.range];
			[arrayOfMatchStrings addObject:substringForMatch];
			
		}
		
		if ([[arrayOfMatchStrings objectAtIndex:0] isKindOfClass:[NSString class]]) {
			theIP = [arrayOfMatchStrings objectAtIndex:0];
			
		}
	}
	else {
		NSLog(@"Oops... g %ld, %@", [error code], [error localizedDescription]);
	}
	return theIP;
}

- (NSString *)getHostName {
	NSHost *theHost = [NSHost hostWithAddress:[self checkIP]];
	return [theHost name];
}

- (IBAction)showPopover:(id)sender {
	[_popover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMaxYEdge];
}

- (IBAction)windowQuit:(id)sender {
	[NSApp terminate:nil];
}

- (IBAction)popoverQuit:(id)sender {
	[NSApp terminate:nil];
}

- (NSWindow *)detachableWindowForPopover:(NSPopover *)popover {
	return _window;
}


@end
