//
//  VWTUserDefaultsManager.m
//  GDIP
//
//  Created by Phaedra Deepsky on 2013-02-16.

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
		[self verifyCopyButtonStatus];
    }
    return self;
}


- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"masterCheckBox"] && [change[@"new"] boolValue]) {
		[self.userDefaults setBool:YES forKey:@"externalIPCheckBox"];
		[self.userDefaults setBool:YES forKey:@"externalHostCheckBox"];
		[self.userDefaults setBool:YES forKey:@"localIPCheckBox"];
		[self.userDefaults setBool:YES forKey:@"localHostCheckBox"];
		
	}
	if ([keyPath isEqualToString:@"externalIPCheckBox"] |
		[keyPath isEqualToString:@"externalHostCheckBox"] |
		[keyPath isEqualToString:@"localIPCheckBox"] |
		[keyPath isEqualToString:@"localHostCheckBox"] &&
		![change[@"new"] boolValue])
	{
		[self.userDefaults setBool:NO forKey:@"masterCheckBox"];
	}
	
	[self verifyCopyButtonStatus];
}

- (void)verifyCopyButtonStatus
{
	if ([self.userDefaults boolForKey:@"externalIPCheckBox"] |
		[self.userDefaults boolForKey:@"externalHostCheckBox"] |
		[self.userDefaults boolForKey:@"localIPCheckBox"] |
		[self.userDefaults boolForKey:@"localHostCheckBox"])
	{
		[self.userDefaults setBool:YES forKey:@"copyButtonEnabled"];
	}
	else
	{
		[self.userDefaults setBool:NO forKey:@"copyButtonEnabled"];
	}

}

- (NSDictionary *)checkCopyableItems
{
	NSMutableDictionary *copyableItems = [NSMutableDictionary dictionary];
	
	if ([self.userDefaults boolForKey:@"externalIPCheckBox"]) {
		copyableItems[@"externalIP"] = @YES;
	}
	if ([self.userDefaults boolForKey:@"externalHostCheckBox"]) {
		copyableItems[@"externalHost"] = @YES;
	}
	if ([self.userDefaults boolForKey:@"localIPCheckBox"]) {
		copyableItems[@"localIP"] = @YES;
	}
	if ([self.userDefaults boolForKey:@"localHostCheckBox"]) {
		copyableItems[@"localHost"] = @YES;
	}
	return copyableItems;
	
}

@end
