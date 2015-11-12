//
//  BTOAddShortCutViewController.m
//  test
//
//  Created by Brian Olencki on 10/17/15.
//  Copyright © 2015 bolencki13. All rights reserved.
//

#import "BTOAddShortCutViewController.h"

@implementation BTOAddShortCutViewController
@synthesize txtBundleID = _txtBundleID, txtTitle = _txtTitle, txtSubTitle = _txtSubTitle, txtNSURL = _txtNSURL, iconNumber = _iconNumber;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *btnHideKeyBoard = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnHideKeyBoard addTarget:self action:@selector(dismissKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [btnHideKeyBoard setFrame:CGRectMake(SCREEN.size.width-125, 20, 125, 50)];
    [btnHideKeyBoard setTitle:@"Hide Keyboard" forState:UIControlStateNormal];
    [self.view addSubview:btnHideKeyBoard];

    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btnBack setFrame:CGRectMake(10, 20, 50, 50)];
    [btnBack setTitle:@"Back" forState:UIControlStateNormal];
    [self.view addSubview:btnBack];

    _txtTitle = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, SCREEN.size.width-20, 30)];
    _txtTitle.placeholder = @"Title";
    _txtTitle.textAlignment = NSTextAlignmentCenter;
    _txtTitle.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:_txtTitle];

    _txtSubTitle = [[UITextField alloc] initWithFrame:CGRectMake(10, 140, SCREEN.size.width-20, 30)];
    _txtSubTitle.placeholder = @"Sub-title";
    _txtSubTitle.textAlignment = NSTextAlignmentCenter;
    _txtSubTitle.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:_txtSubTitle];

    _txtBundleID = [[UITextField alloc] initWithFrame:CGRectMake(10, 180, SCREEN.size.width-20, 30)];
    _txtBundleID.placeholder = @"Bundle ID";
    _txtBundleID.textAlignment = NSTextAlignmentCenter;
    _txtBundleID.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _txtBundleID.autocorrectionType = UITextAutocorrectionTypeNo;
    _txtBundleID.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:_txtBundleID];

    _txtNSURL = [[UITextField alloc] initWithFrame:CGRectMake(10, 220, SCREEN.size.width-20, 30)];
    _txtNSURL.placeholder = @"URL Scheme-\%@ = input";
    _txtNSURL.textAlignment = NSTextAlignmentCenter;
    _txtNSURL.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _txtNSURL.autocorrectionType = UITextAutocorrectionTypeNo;
    _txtNSURL.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:_txtNSURL];


    _iconNumber = 0;
    aryIcons = [[NSMutableArray alloc] initWithObjects:
                @"Add",
                //                @"Alarm",
                //                @"Audio",
                //                @"Bookmark",
                //                @"CapturePhoto",
                //                @"CaptureVideo",
                //                @"Cloud",
                @"Compose",
                //                @"Confirm",
                //                @"Contact",
                //                @"Date",
                //                @"Favorite",
                //                @"Home",
                //                @"Invitation",
                @"Location",
                //                @"Love",
                //                @"Mail",
                //                @"MarkLocation",
                //                @"Messages",
                @"Pause",
                @"Play",
                //                @"Prohibit",
                @"Search",
                @"Share",
                //                @"Shuffle",
                //                @"Task",
                //                @"TaskComplete",
                //                @"Time",
                //                @"Update",
                // @"Custom Image",
                nil];

    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(SCREEN.size.width/8, 250, SCREEN.size.width*3/4, 100)];
    [pickerView setDataSource: self];
    [pickerView setDelegate: self];
    pickerView.showsSelectionIndicator = YES;
    [self.view addSubview: pickerView];

    pickedImage = @"";
}

#pragma mark - UIButton Functions
- (void)dismissKeyboard {
    for (UIView *view in self.view.subviews) {
        if ([view isMemberOfClass:[UITextField class]]) {
            [((UITextField*)view) resignFirstResponder];
        }
    }
}

#pragma mark - Other
- (void)back {
    [self dismissKeyboard];
    [[BTOShortCutManager sharedInstance] addShortCutWithTitle:_txtTitle.text withSubTitle:_txtSubTitle.text withBundleID:_txtBundleID.text withURL:_txtNSURL.text withIcon:_iconNumber withImage:pickedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setIconNumber:(NSInteger)iconNumber {
    [pickerView selectRow:iconNumber inComponent:0 animated:YES];
    _iconNumber = iconNumber;
}

#pragma mark - UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [aryIcons count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [aryIcons objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _iconNumber = row;
    return;
    if (_iconNumber == [aryIcons count]-1) {
      UIImagePickerController *picker = [[UIImagePickerController alloc] init];
      picker.delegate = self;
      picker.allowsEditing = YES;
      picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
      [self presentViewController:picker animated:YES completion:NULL];
    }
}

#pragma mark - UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    pickedImage = info[UIImagePickerControllerReferenceURL];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self dismissKeyboard];
}
@end
