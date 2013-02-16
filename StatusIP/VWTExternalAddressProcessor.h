//  GDIP - VWTExternalAddressProcessor.h
//
//  Created by Phaedra Deepsky on 2013-02-05.

#import <Foundation/Foundation.h>


@protocol VWTExternalAddressProcessorDelegate <NSObject>
@required

- (void)ipAndHostWereSet;

@end

@interface VWTExternalAddressProcessor : NSObject <NSURLConnectionDelegate>

- (void)retrieveIPAndHost;

@property (readonly) NSMutableDictionary* addressAndHostName;
@property (weak) id <VWTExternalAddressProcessorDelegate> delegate;

@end