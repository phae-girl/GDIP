//  GDIP - VWTExternalAddressProcessor.h
//
//  Created by Phaedra Deepsky on 2013-02-05.

#import <Foundation/Foundation.h>
#define EAP_EXTERNAL_IP @"externalIPAddress"
#define EAP_EXTERNAL_HOST @"externalHostName"
#define EAP_LOCAL_IP @"localIPAddress"
#define EAP_LOCAL_HOST @"localHostName"
#define EAP_LOCALIZED_NAME @"localizedName"

@protocol VWTExternalAddressProcessorDelegate <NSObject>
@required

- (void)processorDidRetriveAddressesAndHosts: (NSDictionary *)addressesAndHosts;

@end

@interface VWTExternalAddressProcessor : NSObject <NSURLConnectionDelegate>

@property (assign, nonatomic) id <VWTExternalAddressProcessorDelegate> delegate;

@end