//
//  TestClass.h
//  StatusIP
//
//  Created by Phaedra Deepsky on 2013-02-05.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestClass : NSObject <NSURLConnectionDelegate>

- (void)loadThePage;
- (NSArray *)getIPAndHost;

@end
