//
//  BTOAddShortCutViewController.h
//  test
//
//  Created by Brian Olencki on 10/17/15.
//  Copyright © 2015 bolencki13. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTOShortCutManager.h"

@interface BTOAddShortCutViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UITextField *_txtTitle;
    UITextField *_txtSubTitle;
    UITextField *_txtBundleID;
    UITextField *_txtNSURL;
    NSString *pickedImage;

    NSArray *aryIcons;
    UIPickerView *pickerView;
    NSInteger _iconNumber;
}
@property (retain, nonatomic) UITextField *txtTitle;
@property (retain, nonatomic) UITextField *txtSubTitle;
@property (retain, nonatomic) UITextField *txtBundleID;
@property (retain, nonatomic) UITextField *txtNSURL;
@property (nonatomic) NSInteger iconNumber;
- (void)setIconNumber:(NSInteger)iconNumber;
@end
