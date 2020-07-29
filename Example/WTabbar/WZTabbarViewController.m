//
//  WZTabbarViewController.m
//  WZTabbar
//
//  Created by 牛胖胖 on 2019/12/9.
//  Copyright © 2019 我主良缘. All rights reserved.
//

#import "WTABBARPREFIXViewController.h"
#import "WZTabbarViewController.h"
#import <objc/runtime.h>
#import "WZMessageTabbarItem.h"
#import "WTabBar.h"
@interface WZTabbarViewController ()<UITabBarDelegate,UITabBarControllerDelegate>


@end

@implementation WZTabbarViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
   
    UINavigationController *navi0 = [[UINavigationController alloc]initWithRootViewController:[WTABBARPREFIXViewController new]];
    UINavigationController *navi1 = [[UINavigationController alloc]initWithRootViewController:[WTABBARPREFIXViewController new]];
    UINavigationController *navi2 = [[UINavigationController alloc]initWithRootViewController:[WTABBARPREFIXViewController new]];
    UINavigationController *navi3 = [[UINavigationController alloc]initWithRootViewController:[WTABBARPREFIXViewController new]];
   
    navi0.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"tabbar_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_home_light_ios"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    navi0.tabBarItem.titlePositionAdjustment = UIOffsetMake(0,-2);
    
    
    navi1.tabBarItem = [UITabBarItem initWithTitle:@"消息" image:[[UIImage imageNamed:@"mes"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] customItem:[[WZMessageTabbarItem alloc] initWith:@"tabbar_mes.json"]];

    navi2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"搜索" image:[[UIImage imageNamed:@"search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"search_light"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    navi2.tabBarItem.wzCustomView = [[WZMessageTabbarItem alloc] initWith:@"tabbar_search.json"];
    
    navi3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"tabbar_person"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_person_light"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    navi3.tabBarItem.titlePositionAdjustment = UIOffsetMake(0,-1);
    navi3.tabBarItem.wzItemSize = CGSizeMake(100, 49);
    
    WTabBar *xxxx = [WTabBar new];
    [self setValue:xxxx forKeyPath:@"tabBar"];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : UIColor.orangeColor} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : UIColor.redColor} forState:UIControlStateSelected];
    /// ios 13 必须设置
    self.tabBar.tintColor = UIColor.redColor;
    
    self.viewControllers = @[navi0,navi1,navi2,navi3];
    self.selectedIndex = 0;
   
//    [navi0.tabBarItem showBadgeWith:@"12" withPoint:CGPointMake(3, 3)];
//    [navi1.tabBarItem showBadgeWith:@"99+" withPoint:CGPointMake(3, 3)];
//    [navi2.tabBarItem showBadgeWith:nil withPoint:CGPointMake(10, 3)];
//    [navi3.tabBarItem showBadgeWith:@"new" withPoint:CGPointMake(3, 3)];
    NSMutableArray* array = [NSMutableArray array];
     for (int i = 0; i < 10; i++) {
         CGFloat num = arc4random() % 100 + 1;
         [array addObject:[NSNumber numberWithFloat:num]];
     }
 
    int maxValue = [[array valueForKeyPath:@"@max.intValue"] intValue];
     
     NSLog(@"原生：%@  当前最大：%d",array, maxValue);
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"我被点击了xx%d",item.enabled);
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
   
//    if ([self checkIsDoubleClick:viewController]) {
//         NSLog(@"xxxx");
//        return NO;
//     }
    
     return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
   NSLog(@"1111");
}

- (BOOL)checkIsDoubleClick:(UIViewController *)viewController
{
    static UIViewController *lastViewController = nil;
    static NSTimeInterval lastClickTime = 0;
    
    if (lastViewController != viewController) {
        lastViewController = viewController;
        lastClickTime = [NSDate timeIntervalSinceReferenceDate];
        
        return NO;
    }
    
    NSTimeInterval clickTime = [NSDate timeIntervalSinceReferenceDate];
    if (clickTime - lastClickTime > 0.5 ) {
        lastClickTime = clickTime;
        return NO;
    }
    
    lastClickTime = clickTime;
    return YES;
}



@end
