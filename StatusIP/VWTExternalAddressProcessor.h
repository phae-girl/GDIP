//
//  TestClass.h
//  StatusIP
//
//  Created by Phaedra Deepsky on 2013-02-05.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import <Foundation/Foundation.h>

//@class TestClass;
@protocol VWTExternalAddressProcessorDelegate <NSObject>
@required

- (void)ipAndHostWereSet;

@end


@interface VWTExternalAddressProcessor : NSObject <NSURLConnectionDelegate>

- (void)retrieveIPAndHost;


@property (readonly) NSMutableDictionary* addressAndHostName;
@property (weak) id <VWTExternalAddressProcessorDelegate> delegate;




@end
