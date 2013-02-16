//
//  TestClass.h
//  StatusIP
//
//  Created by Phaedra Deepsky on 2013-02-05.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import <Foundation/Foundation.h>

//@class TestClass;
@protocol TestClassDelegate <NSObject>
@required

- (void)ipAndHostDidGetSet;

@end


@interface VWTExternalAddressProcessor : NSObject <NSURLConnectionDelegate>

- (void)loadThePage;
//- (NSArray *)getIPAndHost;

@property (readonly) NSMutableDictionary* addressAndHostName;
@property (weak) id <TestClassDelegate> delegate;




@end
