//
//  WebViewController.m
//  TigerOfSweden
//
//  Created by Muhammad Fahied on 12/06/14.
//  Copyright (c) 2014 Muhammad Fahied. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    navBar.translucent = NO;
    navBar.backgroundColor = [UIColor whiteColor];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    navItem.title = @"Product Description";

    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(dismissThis)];
    navItem.rightBarButtonItem = rightButton;
    navBar.items = @[ navItem ];
    
    [self.view addSubview:navBar];
    
    
    NSLog(@"URL .%@", self.pageUrlString);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_pageUrlString]];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:request];
}


- (void)dismissThis
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

    [super viewWillAppear:animated];
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeBottom];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if((interfaceOrientation==UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation==UIInterfaceOrientationLandscapeRight))
        self.view.frame = CGRectMake(0,0,480,300);
    else
        self.view.frame = CGRectMake(0,0,320,460);
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma Webview delegat methods
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *absoluteUrlString = [request.URL absoluteString];
    if([absoluteUrlString hasPrefix:@"namshi://?mesage"]) {
        // grab message and display
        NSString *message = [[absoluteUrlString componentsSeparatedByString:@"="]firstObject];
        [[[UIAlertView alloc]initWithTitle:@"Message!" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return NO;
    }
    return  YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
