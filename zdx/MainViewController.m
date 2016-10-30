//
//  MainViewController.m
//  zdx
//
//  Created by 王征 on 16/8/27.
//  Copyright © 2016年 王征. All rights reserved.
//

#import "MainViewController.h"
#import "SettingViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.webUrl != nil && ![@"" isEqualToString:self.webUrl]) {
        NSURL * url = [NSURL URLWithString:self.webUrl];//创建URL
        NSURLRequest * request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
        [self.webView loadRequest:request];//加载
    }
    
    [self checkUrl];
}

- (void) checkUrl {
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    self.ip = [user objectForKey:@"ip"];
    self.port = [user objectForKey:@"port"];
    self.url = [user objectForKey:@"url"];
    self.usrid = [user objectForKey:@"usrid"];
    self.password = [user objectForKey:@"password"];
    
    if (self.ip == nil || [@"" isEqualToString:self.ip]) {
        return;
    }
    if (self.port == nil || [@"" isEqualToString:self.port]) {
        return;
    }
    if (self.usrid == nil || [@"" isEqualToString:self.usrid]) {
        return;
    }
    if (self.password == nil || [@"" isEqualToString:self.password]) {
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
        
        if (![self.url isEqualToString:responseString]) {
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
            
            self.webUrl = webUrl;
            NSURL * url = [NSURL URLWithString:webUrl];//创建URL
            NSURLRequest * request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
            [self.webView loadRequest:request];//加载
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        SettingViewController * svc = [[SettingViewController alloc] init];
//        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:svc];
        [UIApplication sharedApplication].delegate.window.rootViewController = svc;
    }];
}

- (void) viewWillAppear:(BOOL)animated {
    
}

- (void) viewDidAppear:(BOOL)animated {

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

@end
