//
//  TestClass.m
//  StatusIP
//
//  Created by Phaedra Deepsky on 2013-02-05.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass {
	NSURL *baseURL;
	NSURLRequest *request;
	NSURLConnection *conn;
	NSMutableData *responseData;
	NSString *content;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"TestClass Init!");
		baseURL = [NSURL URLWithString:@"http://checkip.dyndns.com/"];
		request = [NSURLRequest requestWithURL:baseURL];
		conn = [NSURLConnection connectionWithRequest:request delegate:self];
		responseData = [NSMutableData data];
		
    }
    return self;
}

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
	NSLog(@"Connection finished data %@", content);
}


@end
