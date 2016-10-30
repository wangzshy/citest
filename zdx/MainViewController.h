//
//  MainViewController.h
//  zdx
//
//  Created by 王征 on 16/8/27.
//  Copyright © 2016年 王征. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (copy, nonatomic) NSString *webUrl;

@property (copy, nonatomic) NSString * ip;
@property (copy, nonatomic) NSString * port;
@property (copy, nonatomic) NSString * url;
@property (copy, nonatomic) NSString * usrid;
@property (copy, nonatomic) NSString * password;

@end
