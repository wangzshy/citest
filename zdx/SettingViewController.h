//
//  SettingViewController.h
//  zdx
//
//  Created by 王征 on 16/8/28.
//  Copyright © 2016年 王征. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;
@property (weak, nonatomic) IBOutlet UITextField *ipTv;
@property (weak, nonatomic) IBOutlet UITextField *portTv;
@property (weak, nonatomic) IBOutlet UITextField *usridTv;
@property (weak, nonatomic) IBOutlet UITextField *passwordTv;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (copy, nonatomic) NSString * ip;
@property (copy, nonatomic) NSString * port;
@property (copy, nonatomic) NSString * url;
@property (copy, nonatomic) NSString * usrid;
@property (copy, nonatomic) NSString * password;

- (IBAction)login:(id)sender;

@end
