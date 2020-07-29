//
//  WTABBARPREFIXViewController.m
//  WTabbar
//
//  Created by wby0214 on 07/29/2020.
//  Copyright (c) 2020 wby0214. All rights reserved.
//

#import "WTABBARPREFIXViewController.h"
#import "demo1ViewController.h"
@interface WTABBARPREFIXViewController ()

@end

@implementation WTABBARPREFIXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.view.userInteractionEnabled = YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    demo1ViewController *vc = [demo1ViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


// 重写系统导航栏是否显示
- (BOOL)hidesBottomBarWhenPushed
{
    [super hidesBottomBarWhenPushed];
    return self.navigationController.topViewController != self;;
}

@end
