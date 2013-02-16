//
//  TestClass.m
//  StatusIP
//
//  Created by Phaedra Deepsky on 2013-02-05.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTExternalAddressProcessor.h"

@implementation VWTExternalAddressProcessor {
	//NSURL *baseURL;
	//NSURLRequest *request;
	NSURLConnection *conn;
	NSMutableData *responseData;
	//NSString *content;
	//NSString *myString;
}

@synthesize addressAndHostName;
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"TestClass Init!");
		addressAndHostName = [NSMutableDictionary dictionary];
		
    }
    return self;
}

- (void)loadThePage
{
	responseData = [NSMutableData data];
	NSURL *baseURL = [NSURL URLWithString:@"http://checkip.dyndns.com/"];
	NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
	conn = [NSURLConnection connectionWithRequest:request delegate:self];
	
}

- (void)setIPAndHost
{
	NSString *anIP = [self parseIPAddress:[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]];
	[addressAndHostName setValue:anIP forKey:@"address"];
	[addressAndHostName setValue:[[NSHost hostWithAddress:anIP]name] forKey:@"hostname"];
	[self.delegate ipAndHostDidGetSet];
}

- (NSString *)parseIPAddress: (NSString *)anIP
{
	NSError *error;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\d{1,3}.\\d{1,3}.\\d{1,3}.\\d{1,3}"
																		   options:NSRegularExpressionDotMatchesLineSeparators | NSRegularExpressionAnchorsMatchLines
																			 error:&error];
	if (error) {
		return [NSString stringWithFormat:@"Error: %ld %@", [error code], [error localizedDescription]];
	}
	
	NSArray *matchArray = [regex matchesInString:anIP
										 options:0
										   range:NSMakeRange(0, [anIP length])];
	
	NSMutableArray *arrayOfMatchStrings = [NSMutableArray array];
	
	for (NSTextCheckingResult *match in matchArray) {
		NSString *substringForMatch = [anIP substringWithRange:match.range];
		[arrayOfMatchStrings addObject:substringForMatch];
		
	}
	
	if ([[arrayOfMatchStrings objectAtIndex:0] isKindOfClass:[NSString class]]) {
		return [arrayOfMatchStrings objectAtIndex:0];
		
	}
	
	return [NSString stringWithFormat:@"Error: %ld %@", [error code], [error localizedDescription]];
}


//NSURLConnection Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
	NSLog(@"Connection rec'd response");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
	NSLog(@"Connection rec'd data");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[NSAlert alertWithError:error] runModal];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Once this method is invoked, "responseData" contains the complete result
	
	[self setIPAndHost];
	[conn cancel];
}


@end
