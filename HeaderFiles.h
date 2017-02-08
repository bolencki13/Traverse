#import <CoreGraphics/CoreGraphics.h>
#include <libactivator/libactivator.h>
#import <UIKit/UIKit.h>

#define NSLog(FORMAT, ...) NSLog(@"[%@]: %@",@"Traverse" , [NSString stringWithFormat:FORMAT, ##__VA_ARGS__])

@interface UIVisualEffectView(Private)
- (void)_setEffect:(id)arg1;
@end

@interface SBApplicationShortcutMenuItemView : UIView
@property(retain, nonatomic) UIApplicationShortcutItem *shortcutItem; // @synthesize shortcutItem=_shortcutItem;
- (UIImage *)invertImage:(UIImage *)image;
@end

@interface SBIconView : UIView
+ (CGSize)defaultIconImageSize;
+ (CGSize)defaultIconSize;
@end
@interface SBFolderIconView : SBIconView
- (void)setIcon:(id)arg1;
- (id)_folderIconImageView;
@end

@class SBApplicationShortcutMenu;
@interface SBIconController : UIViewController
@property(retain, nonatomic) SBApplicationShortcutMenu *presentedShortcutMenu;
+ (id)sharedInstance;
- (void)_handleShortcutMenuPeek:(id)arg1;
- (void)_revealMenuForIconView:(id)arg1 presentImmediately:(_Bool)arg2;
@end


@interface SBApplicationController : NSObject
+ (id)sharedInstance;
- (id)applicationWithBundleIdentifier:(id)arg1;
- (id)runningApplications;
- (id)allApplications;
- (id)allBundleIdentifiers;
@end
@interface SBApplicationShortcutStoreManager : NSObject
+ (id)sharedManager;
- (void)saveSynchronously;
- (void)setShortcutItems:(id)arg1 forBundleIdentifier:(id)arg2;
- (id)shortcutItemsForBundleIdentifier:(NSString*)arg1;
- (id)init;
@end
@interface SBApplication : NSObject
@property(copy, nonatomic) NSArray *staticShortcutItems;
- (NSString*)bundleIdentifier;
- (id)urlScheme;
@end;

@class SBApplicationShortcutItem;
// @protocol SBApplicationShortcutMenuDelegate <NSObject>
// - (void)applicationShortcutMenu:(SBApplicationShortcutMenu *)arg1 launchApplicationWithIconView:(SBIconView *)arg2;
// - (void)applicationShortcutMenu:(SBApplicationShortcutMenu *)arg1 startEditingForIconView:(SBIconView *)arg2;
// - (void)applicationShortcutMenu:(SBApplicationShortcutMenu *)arg1 activateShortcutItem:(SBApplicationShortcutItem *)arg2 index:(long long)arg3;
//
// @optional
// - (void)applicationShortcutMenuDidPresent:(SBApplicationShortcutMenu *)arg1;
// - (void)applicationShortcutMenuDidDismiss:(SBApplicationShortcutMenu *)arg1;
// @end
@interface SBApplicationShortcutMenu : UIView
@property (nonatomic, assign) BOOL isCC;
@property(retain, nonatomic) SBApplication *application;
- (id)initWithFrame:(CGRect)arg1 application:(id)arg2 iconView:(id)arg3 interactionProgress:(id)arg4 orientation:(long long)arg5;
- (void)_setupViews;
- (void)_peekWithContentFraction:(double)arg1 smoothedBlurFraction:(double)arg2;
- (void)dismissAnimated:(_Bool)arg1 completionHandler:(id)arg2;
- (id)_shortcutItemsToDisplay;
@end
@interface SpringBoard : UIApplication
- (void)reboot;
- (void)powerDown;
- (void)applicationOpenURL:(id)arg1;
- (_Bool)launchApplicationWithIdentifier:(id)arg1 suspended:(_Bool)arg2;
- (void)_rotateView:(id)arg1 toOrientation:(long long)arg2;
- (void)wipeDeviceNow;
@end
@interface SBApplicationShortcutMenuContentView : UIView
- (void)_presentForFraction:(double)arg1;
@end

@interface UIApplicationShortcutIcon()
@end
@interface SBSApplicationShortcutIcon : NSObject
@end
@interface SBSApplicationShortcutItem : NSObject
- (void)setIcon:(id)arg1;
- (void)setLocalizedSubtitle:(id)arg1;
- (void)setLocalizedTitle:(id)arg1;
- (void)setType:(id)arg1;
@end
@interface SBSApplicationShortcutSystemIcon : SBSApplicationShortcutIcon
- (id)initWithType:(UIApplicationShortcutIconType)arg1;
@end
@interface SBSApplicationShortcutCustomImageIcon : SBSApplicationShortcutIcon
- (id)initWithImagePNGData:(id)arg1;
@end
@interface SBSApplicationShortcutContactIcon : SBSApplicationShortcutIcon
-(instancetype)initWithContactIdentifier:(NSString *)contactIdentifier;
-(instancetype)initWithFirstName:(NSString*)firstName lastName:(NSString*)lastName;
-(instancetype)initWithFirstName:(NSString*)firstName lastName:(NSString*)lastName imageData:(NSData*)imageData;
@end
