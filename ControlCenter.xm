#import "HeaderFiles.h"
#import <Traverse/Traverse.h>
#include <objc/runtime.h>

@interface SBControlCenterController : UIViewController
+ (id)sharedInstance;
- (BOOL)isVisible;
@end

@interface SBApplicationShortcutMenu ()
- (id)my_shortcutItemsToDisplay;
@end


%hook SBApplicationShortcutMenu
+ (void)initialize {
	static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class myClass = [self class];

        SEL originalSelector = @selector(_shortcutItemsToDisplay);
        SEL swizzledSelector = @selector(my_shortcutItemsToDisplay);

        Method originalMethod = class_getInstanceMethod(myClass, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(myClass, swizzledSelector);

        BOOL didAddMethod = class_addMethod(myClass,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));

        if (didAddMethod) {
            class_replaceMethod(myClass,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
				HBLogDebug(@"Swizzling '-(id)_shortcutItemsToDisplay;'");
    });
}
- (id)initWithFrame:(struct CGRect)arg1 application:(id)arg2 iconView:(id)arg3 interactionProgress:(id)arg4 orientation:(long long)arg5 {
	self = %orig;

	if ([((SBIconView*)arg3).superview isKindOfClass:NSClassFromString(@"SBControlCenterButton")]) {

	}
	return self;
}
%new
- (id)my_shortcutItemsToDisplay {
	HBLogDebug(@"Calling swizzled method for '-(id)_shortcutItemsToDisplay;'");
	NSMutableArray *objects = [[self my_shortcutItemsToDisplay] mutableCopy];

	if ([[NSClassFromString(@"SBControlCenterController") sharedInstance] isVisible] != YES || self.application.bundleIdentifier == nil) {
		return objects;
	}

	// NSArray *aryObjects;
	// NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:@"com.bolencki13.customft"];
	// if ([prefs integerForKey:@"CCActionType"] == 0) {
	// 	aryObjects = [[TRShortCutManager sharedInstance] shortCutsForAppWithBundleID:bundleID withType:TRShortCutTypeControlCenter];
	// } else if ([prefs integerForKey:@"CCActionType"] == 1) {
	// 	aryObjects = [[TRShortCutManager sharedInstance] shortCutsForAppWithBundleID:bundleID withType:TRShortCutTypeSpringboard];
	// } else {
	// 	aryObjects = [[TRShortCutManager sharedInstance] shortCutsForAppWithBundleID:bundleID withType:TRShortCutTypeAll];
	// }

	NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:@"com.bolencki13.customft"];
	if ([prefs boolForKey:@"addMenu"] == YES) {
			if ([prefs boolForKey:@"addNotEvery"] == NO) {
				SBSApplicationShortcutItem *newAction = [[SBSApplicationShortcutItem alloc] init];
				[newAction setIcon:[[SBSApplicationShortcutSystemIcon alloc] initWithType:UIApplicationShortcutIconTypeAdd]];
				[newAction setLocalizedTitle:@"New"];
				[newAction setLocalizedSubtitle:@"Add New Action"];
				[newAction setType:@"com.bolencki13.customft-newAction"];
				[objects addObject:newAction];
			} else if ([prefs boolForKey:@"addNotEvery"] == YES && [objects count] == 0) {
				SBSApplicationShortcutItem *newAction = [[SBSApplicationShortcutItem alloc] init];
				[newAction setIcon:[[SBSApplicationShortcutSystemIcon alloc] initWithType:UIApplicationShortcutIconTypeAdd]];
				[newAction setLocalizedTitle:@"New"];
				[newAction setLocalizedSubtitle:@"Add New Action"];
				[newAction setType:@"com.bolencki13.customft-newAction"];
				[objects addObject:newAction];
			}
	}
	return objects;
}
%end
