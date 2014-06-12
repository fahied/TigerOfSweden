//
//  WebViewController.h
//  TigerOfSweden
//
//  Created by Muhammad Fahied on 12/06/14.
//  Copyright (c) 2014 Muhammad Fahied. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) NSString *pageUrlString;

@property (weak, nonatomic)id delegate;
@end
