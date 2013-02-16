//  GDIP - VWTExternalAddressProcessor.m
//
//  Created by Phaedra Deepsky on 2013-02-05.

#import "VWTExternalAddressProcessor.h"

@interface VWTExternalAddressProcessor ()
@property (nonatomic) NSURLConnection *connexion;
@property (nonatomic) NSMutableData *responseData;

@end

@implementation VWTExternalAddressProcessor


- (id)init
{
    self = [super init];
    if (self)
	{
		_addressAndHostName = [NSMutableDictionary dictionary];
		[self retrieveIPAndHost];
	}
    return self;
}

- (void)retrieveIPAndHost
{
	self.responseData = [NSMutableData data];
	NSURL *baseURL = [NSURL URLWithString:@"http://checkip.dyndns.com/"];
	NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
	self.connexion = [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)setIPAndHost
{
	NSString *anIP = [self parseIPAddress:[[NSString alloc]initWithData:self.responseData encoding:NSUTF8StringEncoding]];
	[self.addressAndHostName setValue:anIP forKey:@"address"];
	[self.addressAndHostName setValue:[NSHost hostWithAddress:anIP].name forKey:@"hostname"];
	[self.addressAndHostName setValue:[NSHost currentHost].localizedName forKey:@"localizedName"];
	[self.delegate willSetValue:@"This string is from the processor"];
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
		[[NSAlert alertWithError:error] runModal];
		return @"0.0.0.0";
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
	
	if (![[arrayOfMatchStrings objectAtIndex:0] isKindOfClass:[NSString class]])
	{
		[NSAlert alertWithMessageText:@"Something's Wrong!" defaultButton:@"OK" alternateButton:@"" otherButton:@"" informativeTextWithFormat:@"There was an error processing the response from http://checkip.dyndns.com. Verify that the site is actually up and running."];
		return @"0.0.0.0";
	}
	return [arrayOfMatchStrings objectAtIndex:0];
}


//NSURLConnection Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData.length = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[NSAlert alertWithError:error] runModal];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[self setIPAndHost];
	[self.connexion cancel];
}
@end
