//
//  IPHandler.m
//  StatusIP
//
//  Created by Phaedra Deepsky on 2013-02-04.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "IPHandler.h"

@implementation IPHandler {
	NSArray *connectionTestSites;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"Handler init!");
		connectionTestSites = [NSArray arrayWithObjects:@"http://www.google.com", @"http://www.squarespace.com", @"http://www.amazon.com", @"http://www.apple.com", nil];
		
    }
    return self;
}

- (void)someMethod{}

- (BOOL)checkInternetConnection
{
	for (NSString *connectionTestSite in connectionTestSites) {
		NSData *testData = [NSData dataWithContentsOfURL:[NSURL URLWithString:connectionTestSite]];
		if (testData) {
			return YES;
		}
	}
	return NO;
}

- (NSArray *)ipAndHost {
	NSArray *ipAndHost;
	
	NSString *ipAddress;
	NSString *hostName;
	
	
	return ipAndHost;
}

- (NSString *)loadIPPage
{
	NSError *error = nil;
	NSURL *theURL = [NSURL URLWithString:@"http://checkip.dyndns.com/"];
	NSString *thePage = [NSString stringWithContentsOfURL:theURL
												 encoding:NSUTF8StringEncoding
													error:&error];
	if (!thePage && [self checkInternetConnection]) {
		
		NSAlert* alert = [NSAlert alertWithMessageText:@"No Internet Connection"
								defaultButton:@"Ok"
							  alternateButton:nil
								  otherButton:nil
					informativeTextWithFormat:@"Check your internet connexion and try again"];
		[alert runModal];

	}
	
	return thePage;
}

- (NSString *)parseIPAddress: (NSString *)anIP
{
	NSError *error;
	NSMutableArray *arrayOfMatchStrings;
	
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\d{1,3}.\\d{1,3}.\\d{1,3}.\\d{1,3}"
																		   options:NSRegularExpressionDotMatchesLineSeparators | NSRegularExpressionAnchorsMatchLines
																			 error:&error];
	if (error) {
		return [NSString stringWithFormat:@"Error: %ld %@", [error code], [error localizedDescription]];
	}
	
	NSArray *matchArray = [regex matchesInString:anIP
										 options:0
										   range:NSMakeRange(0, [anIP length])];
	
	for (NSTextCheckingResult *match in matchArray) {
		NSString *substringForMatch = [anIP substringWithRange:match.range];
		[arrayOfMatchStrings addObject:substringForMatch];
		
	}
	
	if ([[arrayOfMatchStrings objectAtIndex:0] isKindOfClass:[NSString class]]) {
		return [arrayOfMatchStrings objectAtIndex:0];
		
	}
	
	return [NSString stringWithFormat:@"Error: %ld %@", [error code], [error localizedDescription]];
}

@end
