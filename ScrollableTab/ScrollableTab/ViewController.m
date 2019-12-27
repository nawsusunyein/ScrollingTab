//
//  ViewController.m
//  ScrollableTab
//
//  Created by techfun on 2019/12/27.
//  Copyright © 2019 Naw Su Su Nyein. All rights reserved.
//

#import "ViewController.h"
#import "ScrollTab.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UIView *tabView;
@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

static NSString *const RequestURL = @"https://www.apple.com/";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpTabBar];
    [self setUpWebView];
    [self setURLRequest:RequestURL];
    
}

//Creating tab bar and setting tab bar configuration
-(void) setUpTabBar
{
    ScrollTabConfig *config = [[ScrollTabConfig alloc] init];
    config.underlineIndicatorColor = [UIColor colorWithRed:0 green:163/255.f blue:238.f alpha:1];
    config.showUnderlineIndicator = YES;
    config.unselectedBackgroundColor = [UIColor whiteColor];
    config.selectedBackgroundColor = [UIColor whiteColor];
    config.items = @[@"Google",@"ぷにぶにぷに",@"Facebook",@"Tutorials Points",@"Medium",@"Puni Puni"];
    
    ScrollTab *tab = [[ScrollTab alloc] init];
    tab.config = config;
    tab.selected = ^(NSString *noop, NSInteger index) {
        NSLog(@"selected tab with index %@", @(index));
    };
    [self.tabView addSubview:tab];
    [self.view addSubview:self.tabView];
    
    tab.translatesAutoresizingMaskIntoConstraints = NO;
       
       NSDictionary *views = @{@"tab": tab};
       
       NSDictionary *metrics = @{
                                 @"height": @60,
                                 @"top": @20
                                 };
       NSArray *formats = @[
                            @"|[tab]|",
                            @"V:|-top-[tab(height)]"
                            ];
       [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:kNilOptions metrics:metrics views:views];
           [self.view addConstraints:constraints];
       }];
}


-(void) setUpWebView
{
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    
}

-(void) setURLRequest : (NSString *) requestURLString{
    NSURL *url = [[NSURL alloc] initWithString: requestURLString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url
                                                  cachePolicy: NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval: 5];
    [self.webView loadRequest: request];
}
@end
