//
//  IPHandler.h
//  StatusIP
//
//  Created by Phaedra Deepsky on 2013-02-04.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPHandler : NSObject <NSURLConnectionDelegate>



- (BOOL)checkInternetConnection;
- (NSString *)loadIPPage;
- (NSArray *)ipAndHost;


@end
