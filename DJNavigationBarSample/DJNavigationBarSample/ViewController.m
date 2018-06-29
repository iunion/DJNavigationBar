//
//  ViewController.m
//  DJNavigationBarSample
//
//  Created by DJ on 2018/5/2.
//  Copyright © 2018年 DennisDeng. All rights reserved.
//

#import "ViewController.h"
#import "DJNavigationBarDefine.h"
#import "UIViewController+DJNavigationBar.h"
#import "UIViewController+DJNavigationItem.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSegment;

@property (weak, nonatomic) IBOutlet UISwitch *blackStyleSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *blurEffectSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *barHiddenSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *shadowHiddenSwitch;

@property (weak, nonatomic) IBOutlet UISlider *alphaSlider;
@property (weak, nonatomic) IBOutlet UILabel *alphaComponent;

- (IBAction)blackStyleChanged:(UISwitch *)sender;
- (IBAction)blurEffectChanged:(UISwitch *)sender;
- (IBAction)barHiddenChanged:(UISwitch *)sender;
- (IBAction)shadowHiddenChanged:(UISwitch *)sender;

- (IBAction)alphaChanged:(UISlider *)sender;

- (IBAction)pushToNext:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = NO;
//    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;

    self.dj_NavigationItemTintColor = [UIColor yellowColor];
    if (self.navigationController.viewControllers.count > 1)
    {
        [self dj_setNavigationWithTitle:@"DJNavigationBar" barTintColor:nil leftItemTitle:nil leftItemImage:@"navigationbar_setup_icon" leftToucheEvent:@selector(leftClick) rightItemTitle:@"TT" rightItemImage:@"navigationbar_setup_icon" rightToucheEvent:@selector(rightClick)];

        UIButton *btn = [self dj_getNavigationRightItemAtIndex:0];
        btn.tintColor = [UIColor redColor];
    }
    else
    {
        self.title = @"DJNavigationBar";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_setup_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, 1000);

    self.blurEffectSwitch.on = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"viewWillDisappear");
    
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"viewDidDisappear");
    
    [super viewDidDisappear:animated];
}

- (void)viewWillLayoutSubviews
{
    NSLog(@"viewWillLayoutSubviews");
    
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews
{
    NSLog(@"viewDidLayoutSubviews");
    
    [super viewDidLayoutSubviews];
}

- (void)leftClick
{
    NSLog(@"leftClick");
}

- (void)rightClick
{
    NSLog(@"rightClick");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)alphaChanged:(UISlider *)sender
{
    self.alphaComponent.text = [NSString stringWithFormat:@"%.2f", sender.value];
    self.dj_NavigationBarAlpha = sender.value;
    [self dj_setNeedsUpdateNavigationBarAlpha];
    
    self.dj_NavigationTitleTintColor = [UIColor yellowColor];
    self.dj_NavigationTitleAlpha = sender.value;
    [self dj_setNeedsUpdateNavigationTitleAlpha];
    [self dj_setNeedsUpdateNavigationTitleTintColor];

    self.dj_NavigationItemTintColor = [UIColor redColor];
    [self dj_setNeedsUpdateNavigationItemTintColor];
}

- (IBAction)pushToNext:(id)sender
{
    UIViewController *vc = [self createDemoViewController];
    [vc setNeedsStatusBarAppearanceUpdate];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIViewController *)createDemoViewController
{
    ViewController *vc = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    
    UIColor *color = @[
                       [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:0.8],
                       [UIColor colorWithRed:28/255.0 green:28/255.0 blue:28/255.0 alpha:0.729],
                       [UIColor.redColor colorWithAlphaComponent:0.7],
                       [UIColor.greenColor colorWithAlphaComponent:0.7],
                       [UIColor.blueColor colorWithAlphaComponent:0.8]
                       ][self.colorSegment.selectedSegmentIndex];
    
    vc.dj_NavigationBarBgTintColor = color;

    return vc;
}

- (IBAction)blackStyleChanged:(UISwitch *)sender
{
    if (sender.on)
    {
        self.dj_NavigationBarStyle = UIBarStyleBlack;
    }
    else
    {
        self.dj_NavigationBarStyle = UIBarStyleDefault;
    }
    [self dj_setNeedsUpdateNavigationBarStyle];
}

- (IBAction)blurEffectChanged:(UISwitch *)sender
{
    if (sender.on)
    {
        self.dj_NavigationBarEffect = DJNavigationBar_DefaultEffect;
    }
    else
    {
        self.dj_NavigationBarEffect = [[UIVisualEffect alloc] init];
    }
    [self dj_setNeedsUpdateNavigationBarEffect];
}

- (IBAction)barHiddenChanged:(UISwitch *)sender
{
    self.dj_NavigationBarHidden = sender.on;
    [self dj_setNeedsUpdateNavigationBarAlpha];
}

- (IBAction)shadowHiddenChanged:(UISwitch *)sender
{
    self.dj_NavigationShadowHidden = sender.on;
    [self dj_setNeedsUpdateNavigationShadowAlpha];
}

@end
