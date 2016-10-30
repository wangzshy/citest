//
//  SettingViewController.m
//  zdx
//
//  Created by 王征 on 16/8/28.
//  Copyright © 2016年 王征. All rights reserved.
//

#import "SettingViewController.h"
#import <IQKeyboardManager.h>
#import "MBProgressHUD.h"
#import <AFNetworking/AFNetworking.h>
#import "MainViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"设置";
    self.viewWidth.constant = [UIScreen mainScreen].bounds.size.width;
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * ip = [user objectForKey:@"ip"];
    NSString * port = [user objectForKey:@"port"];
    NSString * usrid = [user objectForKey:@"usrid"];
    NSString * password = [user objectForKey:@"password"];
    
    if ([ip containsString:@"http://"]) {
        ip = [ip stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    }
    
    self.ipTv.text = ip;
    self.portTv.text = port;
    self.usridTv.text = usrid;
    self.passwordTv.text = password;
    
    [self test];
}

- (void) test {
    self.ipTv.text = @"139.224.24.130";
    self.portTv.text = @"8888";
    self.usridTv.text = @"supervisor";
    self.passwordTv.text = @"123456";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)login:(id)sender {
    
    self.ip = self.ipTv.text;
    self.port = self.portTv.text;
    self.usrid = self.usridTv.text;
    self.password = self.passwordTv.text;
    
    if (self.ip == nil || [@"" isEqualToString:self.ip]) {
        [self show:@"IP地址不能为空" icon:nil view:nil];
        return;
    }
    if (self.port == nil || [@"" isEqualToString:self.port]) {
        [self show:@"端口号不能为空" icon:nil view:nil];
        return;
    }
    if (self.usrid == nil || [@"" isEqualToString:self.usrid]) {
        [self show:@"用户名不能为空" icon:nil view:nil];
        return;
    }
    if (self.password == nil || [@"" isEqualToString:self.password]) {
        [self show:@"密码不能为空" icon:nil view:nil];
        return;
    }
    
    NSString * fullUrl = @"";
    if ([self.ip containsString:@"http://"]) {
        fullUrl = [[[self.ip stringByAppendingString:@":"] stringByAppendingString:self.port] stringByAppendingString:@"/servlet/Login.do?portalType=mobile"];
    } else {
        fullUrl = [@"http://" stringByAppendingString:[[[self.ip stringByAppendingString:@":"] stringByAppendingString:self.port] stringByAppendingString:@"/servlet/Login.do?portalType=mobile"]];
    }
    NSDictionary *parameters = @{@"usrid": self.usrid, @"password": self.password, @"action": @"Login"};

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //以post的形式提交，POST的参数就是上面的域名，parameters的参数是一个字典类型，将上面的字典作为它的参数
    [manager POST:fullUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString * responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        self.url = responseString;
        NSLog(@"---获取到的json格式的字典--%@",responseString);
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString * webUrl = @"";
        if ([self.ip containsString:@"http://"]) {
            [user setObject:self.ip forKey:@"ip"];
            webUrl = [[[[self.ip stringByAppendingString:@":"] stringByAppendingString:self.port] stringByAppendingString:@"/"] stringByAppendingString:self.url];
        } else {
            [user setObject:[@"http://" stringByAppendingString:self.ip] forKey:@"ip"];
            webUrl = [@"http://" stringByAppendingString:[[[[self.ip stringByAppendingString:@":"] stringByAppendingString:self.port] stringByAppendingString:@"/"] stringByAppendingString:self.url]];
        }
        
        [user setObject:self.port forKey:@"port"];
        [user setObject:self.usrid forKey:@"usrid"];
        [user setObject:self.password forKey:@"password"];
        [user setObject:responseString forKey:@"url"];
        [user synchronize];

        MainViewController * mvc = [[MainViewController alloc] init];
        mvc.webUrl = webUrl;

        [UIApplication sharedApplication].delegate.window.rootViewController = mvc;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self show:@"请求失败" icon:nil view:nil];
    }];
    
}

- (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    // 设置图片
//    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:0.7];
}
@end














