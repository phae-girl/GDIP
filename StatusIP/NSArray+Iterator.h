//
//  NSArray+Iterator.h
//  GDIP
//
//  Created by Phaedra Deepsky on 2013-03-22.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Iterator)
	- (NSArray *)each:(void(^)(id object))block;
@end
