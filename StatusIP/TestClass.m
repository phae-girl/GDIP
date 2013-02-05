//
//  TestClass.m
//  StatusIP
//
//  Created by Phaedra Deepsky on 2013-02-05.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass {
	//NSURL *baseURL;
	//NSURLRequest *request;
	NSURLConnection *conn;
	NSMutableData *responseData;
	NSString *content;
	NSString *myString;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"TestClass Init!");
				
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

- (NSArray *)getIPAndHost
{
	NSMutableArray *ipAndHost = [NSArray array];
	//[self loadThePage];
	//[self parseIPAddress:content];
	
	[ipAndHost addObject:[self parseIPAddress:content]];
	[ipAndHost addObject:[[NSHost hostWithAddress:[ipAndHost objectAtIndex:0]]name]];
	
	NSLog(@"%@",ipAndHost);
	
	return [NSArray arrayWithArray:ipAndHost];
	
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
	content = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
	myString = [self parseIPAddress:content];
	NSLog(@"Connection finished data %@ %@", content, myString);
	
	[conn cancel];
}


@end
