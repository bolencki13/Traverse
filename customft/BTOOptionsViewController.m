#import "BTOOptionsViewController.h"

#define SCREEN ([UIScreen mainScreen].bounds)

@implementation BTOOptionsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btnBack setFrame:CGRectMake(10, 20, 50, 50)];
    [btnBack setTitle:@"Back" forState:UIControlStateNormal];
    [self.view addSubview:btnBack];

    prefs = [[NSUserDefaults alloc] initWithSuiteName:@"com.bolencki13.customft"];
    [prefs registerDefaults:@{
                              @"blur" : @1,
                              @"addMenu" : @YES,
                              @"addNotEvery" : @NO
                              }];

    UILabel *lblTitleBlur = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 100, 30)];
    lblTitleBlur.text = @"Blur Color:";
    [self.view addSubview:lblTitleBlur];

    UISegmentedControl *sgcBlurStyle = [[UISegmentedControl alloc] initWithItems:@[@"Extra Light",@"Light",@"Dark"]];
    sgcBlurStyle.frame = CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width-20, 50);
    [sgcBlurStyle addTarget:self action:@selector(updateBlur:) forControlEvents: UIControlEventValueChanged];
    sgcBlurStyle.selectedSegmentIndex = [prefs integerForKey:@"blur"];
    [self.view addSubview:sgcBlurStyle];

    UIButton *btnExample1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnExample1 addTarget:self action:@selector(showExample:) forControlEvents:UIControlEventTouchUpInside];
    [btnExample1 setFrame:CGRectMake(20, 160, [UIScreen mainScreen].bounds.size.width/2-45, 50)];
    [btnExample1 setTitle:@"URLScheme ex1" forState:UIControlStateNormal];
    [btnExample1 setTag:1];
    [self.view addSubview:btnExample1];

    UIButton *btnExample2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnExample2 addTarget:self action:@selector(showExample:) forControlEvents:UIControlEventTouchUpInside];
    [btnExample2 setFrame:CGRectMake(SCREEN.size.width/2+5, 160, SCREEN.size.width/2-45, 50)];
    [btnExample2 setTitle:@"URLScheme ex2" forState:UIControlStateNormal];
    [btnExample2 setTag:2];
    [self.view addSubview:btnExample2];

    holder = [[UIView alloc] initWithFrame:CGRectMake(0, 220, SCREEN.size.width, 105)];
    [self.view addSubview:holder];
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, SCREEN.size.width-75, 50)];
    lblTitle.text = @"Show Add Action";
    [holder addSubview:lblTitle];
    UISwitch *swcMaster = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN.size.width-70, 10, 65, 50)];
    [swcMaster addTarget:self action:@selector(handleSwitch:) forControlEvents:UIControlEventValueChanged];
    [swcMaster setOn:[prefs boolForKey:@"addMenu"] animated:YES];
    swcMaster.tag = 0;
    [holder addSubview:swcMaster];
    UIView *viewSubmenu = [[UIView alloc] initWithFrame:CGRectMake(0, 55, SCREEN.size.width, 50)];
    viewSubmenu.tag = 13;
    [holder addSubview:viewSubmenu];
    UILabel *lblSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, SCREEN.size.width-75, 50)];
    lblSubTitle.text = @"Only when no other action";
    [viewSubmenu addSubview:lblSubTitle];
    UISwitch *swcSub = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN.size.width-70, 10, 65, 50)];
    [swcSub addTarget:self action:@selector(handleSwitch:) forControlEvents:UIControlEventValueChanged];
    swcSub.tag = 1;
    [swcSub setOn:[prefs boolForKey:@"addNotEvery"] animated:YES];
    [viewSubmenu addSubview:swcSub];
    [self setSubMenuForState:swcMaster.isOn];
}
- (void)back {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)updateBlur:(UISegmentedControl*)sender {
  [prefs setInteger:sender.selectedSegmentIndex forKey:@"blur"];
}
- (void)showExample:(UIButton*)sender {
    if (sender.tag == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://iphonedevwiki.net/index.php/NSURL"]];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://wiki.akosma.com/IPhone_URL_Schemes"]];
    }
}
- (void)handleSwitch:(UISwitch*)sender {
    if (sender.tag == 0) {
        [prefs setBool:sender.isOn forKey:@"addMenu"];
        [self setSubMenuForState:sender.isOn];
    } else if (sender.tag == 1) {
      [prefs setBool:sender.isOn forKey:@"addNotEvery"];
    }
}
- (void)setSubMenuForState:(BOOL)state {
    if (state == NO) {
        ((UIView*)[holder viewWithTag:13]).alpha = 0.5;
        ((UIView*)[holder viewWithTag:13]).userInteractionEnabled = NO;
    } else {
        ((UIView*)[holder viewWithTag:13]).alpha = 1.0;
        ((UIView*)[holder viewWithTag:13]).userInteractionEnabled = YES;
    }
}
@end
