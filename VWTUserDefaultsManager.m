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
        for (NSString *checkBoxState in self.checkBoxStateKeys) {
            [self.userDefaults addObserver:self forKeyPath:checkBoxState options:NSKeyValueObservingOptionNew context:NULL];
        }
        
        [self.userDefaults addObserver:self forKeyPath:@"masterCheckBoxState" options:NSKeyValueObservingOptionNew context:NULL];
//		[self.userDefaults addObserver:self forKeyPath:@"externalIPAddressCheckBoxState" options:NSKeyValueObservingOptionNew context:NULL];
//		[self.userDefaults addObserver:self forKeyPath:@"externalHostNameCheckBoxState" options:NSKeyValueObservingOptionNew context:NULL];
//		[self.userDefaults addObserver:self forKeyPath:@"localIPAddressCheckBoxState" options:NSKeyValueObservingOptionNew context:NULL];
//		[self.userDefaults addObserver:self forKeyPath:@"localHostNameCheckBoxState" options:NSKeyValueObservingOptionNew context:NULL];

		[self verifyCopyButtonStatus];
    }
    return self;
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"masterCheckBoxState"] && [change[@"new"] boolValue]) {
		for (NSString *checkBoxState in self.checkBoxStateKeys) {
			[self.userDefaults setBool:YES forKey:checkBoxState];
		}
		
//		[self.userDefaults setBool:YES forKey:@"externalIPAddressCheckBoxState"];
//		[self.userDefaults setBool:YES forKey:@"externalHostNameCheckBoxState"];
//		[self.userDefaults setBool:YES forKey:@"localIPAddressCheckBoxState"];
//		[self.userDefaults setBool:YES forKey:@"localHostNameCheckBoxState"];
		
	}
	for (NSString *checkBoxState in self.checkBoxStateKeys) {
		if ([keyPath isEqualToString:checkBoxState] && ![change[@"new"] boolValue]) {
			[self.userDefaults setBool:NO forKey:@"masterCheckBoxState"];
			break;
		}
	}
	
//	if ([keyPath isEqualToString:@"externalIPAddressCheckBoxState"] |
//		[keyPath isEqualToString:@"externalHostNameCheckBoxState"] |
//		[keyPath isEqualToString:@"localIPAddressCheckBoxState"] |
//		[keyPath isEqualToString:@"localHostNameCheckBoxState"] &&
//		![change[@"new"] boolValue])
//	{
//		[self.userDefaults setBool:NO forKey:@"masterCheckBoxState"];
//	}
	[self verifyCopyButtonStatus];
}

- (void)verifyCopyButtonStatus
{
    for (NSString *checkBoxState in self.checkBoxStateKeys) {
        if ([self.userDefaults boolForKey:checkBoxState]) {
            [self.userDefaults setBool:YES forKey:@"copyButtonState"];
            break;
        }
        else
            [self.userDefaults setBool:NO forKey:@"copyButtonState"];
        
    }

//	if ([self.userDefaults boolForKey:@"externalIPAddressCheckBoxState"] |
//		[self.userDefaults boolForKey:@"externalHostNameCheckBoxState"] |
//		[self.userDefaults boolForKey:@"localIPAddressCheckBoxState"] |
//		[self.userDefaults boolForKey:@"localHostNameCheckBoxState"])
//	{
//		[self.userDefaults setBool:YES forKey:@"copyButtonState"];
//	}
//	else
//	{
//		[self.userDefaults setBool:NO forKey:@"copyButtonState"];
//	}
}

- (NSDictionary *)checkCopyableItems
{
	NSDictionary *copyableItems = @{@"externalIPAddressIsCopyable": [NSNumber numberWithBool:[self.userDefaults boolForKey:@"externalIPAddressCheckBoxState"]],
								 @"externalHostNameIsCopyable": [NSNumber numberWithBool:[self.userDefaults boolForKey:@"externalHostNameCheckBoxState"]],
								 @"localIPAddressIsCopyable": [NSNumber numberWithBool:[self.userDefaults boolForKey:@"localIPAddressCheckBoxState"]],
								 @"localHostNameIsCopyable": [NSNumber numberWithBool:[self.userDefaults boolForKey:@"localHostNameCheckBoxState"]]};

//	NSMutableDictionary *copyableItems = [NSMutableDictionary dictionary];
//	
//	if ([self.userDefaults boolForKey:@"externalIPAddressCheckBoxState"]) {
//		copyableItems[@"externalIPAddressIsCopyable"] = @YES;
//	}
//	if ([self.userDefaults boolForKey:@"externalHostNameCheckBoxState"]) {
//		copyableItems[@"externalHostNameIsCopyable"] = @YES;
//	}
//	if ([self.userDefaults boolForKey:@"localIPAddressCheckBoxState"]) {
//		copyableItems[@"localIPAddressIsCopyable"] = @YES;
//	}
//	if ([self.userDefaults boolForKey:@"localHostNameCheckBoxState"]) {
//		copyableItems[@"localHostNameIsCopyable"] = @YES;
//	}
	return copyableItems;
}

@end
