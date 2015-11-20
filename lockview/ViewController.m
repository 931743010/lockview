//
//  ViewController.m
//  lockview
//
//  Created by lbq on 15/11/18.
//  Copyright © 2015年 linbq. All rights reserved.
//

#import "ViewController.h"
#import "LockView.h"
@interface ViewController ()<LockViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//实现代理方法
-(void)lockView:(LockView *)lockView didFinishPath:(NSString *)path{
    //模拟读取后台方法验证密码
    if ([path isEqualToString:@"123698745"]) {
        //密码正确,进入app
        
    }else{
        //密码错误,提示
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码错误(测试提示:123698745)" message:nil preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault          handler:nil ]];
        
        
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

@end
