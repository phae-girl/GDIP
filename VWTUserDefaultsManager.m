//
//  VWTUserDefaultsManager.m
//  GDIP
//
//  Created by Phaedra Deepsky on 2013-02-16.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTUserDefaultsManager.h"

@interface VWTUserDefaultsManager ()
@property NSUserDefaults *userDefaults;

@end

@implementation VWTUserDefaultsManager

- (id)init
{
    self = [super init];
    if (self) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
		[self.userDefaults addObserver:self forKeyPath:@"masterCheckBox" options:NSKeyValueObservingOptionNew context:NULL];
		[self.userDefaults addObserver:self forKeyPath:@"externalIPCheckBox" options:NSKeyValueObservingOptionNew context:NULL];
		[self.userDefaults addObserver:self forKeyPath:@"externalHostCheckBox" options:NSKeyValueObservingOptionNew context:NULL];
		[self.userDefaults addObserver:self forKeyPath:@"localIPCheckBox" options:NSKeyValueObservingOptionNew context:NULL];
		[self.userDefaults addObserver:self forKeyPath:@"localHostCheckBox" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}


- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"masterCheckBox"] && [change[@"new"] boolValue]) {
		[self.userDefaults setValue:@YES forKey:@"externalIPCheckBox"];
		[self.userDefaults setValue:@YES forKey:@"externalHostCheckBox"];
		[self.userDefaults setValue:@YES forKey:@"localIPCheckBox"];
		[self.userDefaults setValue:@YES forKey:@"localHostCheckBox"];
		
	}
	if ([keyPath isEqualToString:@"externalIPCheckBox"] |
		[keyPath isEqualToString:@"externalHostCheckBox"] |
		[keyPath isEqualToString:@"localIPCheckBox"] |
		[keyPath isEqualToString:@"localHostCheckBox"] &&
		![change[@"new"] boolValue])
	{
		[self.userDefaults setValue:@NO forKey:@"masterCheckBox"];
	}
}

@end
