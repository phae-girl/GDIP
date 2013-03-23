//
//  VWTUserDefaultsManager.m
//  GDIP
//
//  Created by Phaedra Deepsky on 2013-02-16.

#import "VWTUserDefaultsManager.h"

@interface VWTUserDefaultsManager ()
@property NSUserDefaults *userDefaults;
@property NSArray *checkBoxStateKeys;

@end

@implementation VWTUserDefaultsManager

- (id)init
{
	self = [super init];
	if (self) {
		_checkBoxStateKeys = @[@"externalIPAddressCheckBoxState", @"externalHostNameCheckBoxState", @"localIPAddressCheckBoxState", @"localHostNameCheckBoxState"];
		_userDefaults = [NSUserDefaults standardUserDefaults];
		[self.checkBoxStateKeys each:^(NSString *checkBoxState){
			[self.userDefaults addObserver:self forKeyPath:checkBoxState options:NSKeyValueObservingOptionNew context:NULL];
		}];
		
		[self.userDefaults addObserver:self forKeyPath:@"masterCheckBoxState" options:NSKeyValueObservingOptionNew context:NULL];
		[self verifyCopyButtonStatus];
	}
	return self;
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"masterCheckBoxState"] && [change[@"new"] boolValue]) {
		[self.checkBoxStateKeys each:^(NSString *checkBoxState){
			[self.userDefaults setBool:YES forKey:checkBoxState];
		}];
	}
	//Can't be used with block model because of break
	for (NSString *checkBoxState in self.checkBoxStateKeys) {
		if ([keyPath isEqualToString:checkBoxState] && ![change[@"new"] boolValue]) {
			[self.userDefaults setBool:NO forKey:@"masterCheckBoxState"];
			break;
		}
	}
	
	[self verifyCopyButtonStatus];
}

- (void)verifyCopyButtonStatus
{
	//Can't be used with block model because of break
	for (NSString *checkBoxState in self.checkBoxStateKeys) {
		if ([self.userDefaults boolForKey:checkBoxState]) {
			[self.userDefaults setBool:YES forKey:@"copyButtonState"];
			break;
		}
		else
			[self.userDefaults setBool:NO forKey:@"copyButtonState"];
		
	}
}

- (NSDictionary *)checkCopyableItems
{
	NSDictionary *copyableItems = @{@"externalIPAddressIsCopyable": [NSNumber numberWithBool:[self.userDefaults boolForKey:@"externalIPAddressCheckBoxState"]],
								 @"externalHostNameIsCopyable": [NSNumber numberWithBool:[self.userDefaults boolForKey:@"externalHostNameCheckBoxState"]],
								 @"localIPAddressIsCopyable": [NSNumber numberWithBool:[self.userDefaults boolForKey:@"localIPAddressCheckBoxState"]],
								 @"localHostNameIsCopyable": [NSNumber numberWithBool:[self.userDefaults boolForKey:@"localHostNameCheckBoxState"]]};
	return copyableItems;
}

@end
