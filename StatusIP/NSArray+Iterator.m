//
//  NSArray+Iterator.m
//  GDIP
//
//  Created by Phaedra Deepsky on 2013-03-22.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "NSArray+Iterator.h"

@implementation NSArray (Iterator)

- (NSArray *)each:(void(^)(id object))block {
	for (id myObj in self) {
		block(myObj);
	}
	return self;
}

@end
