//  StatusIP
//
//  Created by Phaedra Deepsky on 2013-02-05.

#import "VWTExternalAddressProcessor.h"

@implementation VWTExternalAddressProcessor {

	NSURLConnection *conn;
	NSMutableData *responseData;

}

@synthesize addressAndHostName;
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
	{
		addressAndHostName = [NSMutableDictionary dictionary];
	}
    return self;
}

- (void)retrieveIPAndHost
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
	[self.delegate ipAndHostWereSet];
}

- (NSString *)parseIPAddress: (NSString *)anIP
{
	NSError *error;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}"
																		   options:NSRegularExpressionDotMatchesLineSeparators | NSRegularExpressionAnchorsMatchLines
																			 error:&error];
	if (error)
	{
		return [NSString stringWithFormat:@"Error: %ld %@", [error code], [error localizedDescription]];
	}
	
	NSArray *matchArray = [regex matchesInString:anIP
										 options:0
										   range:NSMakeRange(0, [anIP length])];
	
	NSMutableArray *arrayOfMatchStrings = [NSMutableArray array];
	
	for (NSTextCheckingResult *match in matchArray)
	{
		NSString *substringForMatch = [anIP substringWithRange:match.range];
		[arrayOfMatchStrings addObject:substringForMatch];
		
	}
	
	if ([[arrayOfMatchStrings objectAtIndex:0] isKindOfClass:[NSString class]])
	{
		return [arrayOfMatchStrings objectAtIndex:0];
		
	}
	
	return [NSString stringWithFormat:@"Error: %ld %@", [error code], [error localizedDescription]];
}


//NSURLConnection Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[NSAlert alertWithError:error] runModal];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[self setIPAndHost];
	[conn cancel];
}
@end
