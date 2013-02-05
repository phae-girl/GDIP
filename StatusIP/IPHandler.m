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
	
}

@end
