//
//  BTOAddShortCutViewController.h
//  test
//
//  Created by Brian Olencki on 10/17/15.
//  Copyright © 2015 bolencki13. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTOShortCutManager.h"

@interface BTOInputView : UIView {
    UISegmentedControl *_segmentedControl;
    UITextField *_txtURLScheme;
    UITextField *txtSchellScript;

    NSString *activatorAction;
}
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property (nonatomic, retain) UITextField *txtURLScheme;
- (NSString*)getURL;
@end
@interface BTOAddShortCutViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UITextField *_txtTitle;
    UITextField *_txtSubTitle;
    UITextField *_txtBundleID;
    BTOInputView *viewInput;
    NSString *pickedImage;

    NSArray *aryIcons;
    UIPickerView *pickerView;
    NSInteger _iconNumber;
}
@property (retain, nonatomic) UITextField *txtTitle;
@property (retain, nonatomic) UITextField *txtSubTitle;
@property (retain, nonatomic) UITextField *txtBundleID;
@property (nonatomic) NSInteger iconNumber;
- (void)setIconNumber:(NSInteger)iconNumber;
- (void)setURLText:(NSString*)text;
@end
