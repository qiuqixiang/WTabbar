//
//  UITabBar+WZHook.h
//  WZTabbar
//
//  Created by 牛胖胖 on 2019/12/9.
//  Copyright © 2019 我主良缘. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "WTabBar.h"
NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (WZCustom)


@end

//// MARK - UITabBarItem自定义view的协议
//@protocol UITabBarItemProtocol <NSObject>
//
//@required
//
///// 获取当前视图
//- (UIView *_Nonnull)contentView;
//
///// 告诉自定义视图当前是否被选中
///// @param isSelect 是否被选中
//- (void)uploadSelectItem:(BOOL)isSelect;
//
//@end
//
//// MARK - 自定义UITabBarItem
//@interface UITabBarItem (WZCustom)
//
///// 自定义item
///// @param title 文字
///// @param image 图片
///// @param customView 自定义item
//+ (UITabBarItem *)initWithTitle:(NSString * _Nullable)title image:(UIImage * _Nullable)image customItem:(id<UITabBarItemProtocol> _Nullable)customView;
//+ (UITabBarItem *)initWithCustomItem:(id<UITabBarItemProtocol> _Nullable)customView;
//
//
///// 外部自定义
//@property (strong,nonatomic,nullable) id<UITabBarItemProtocol> wzCustomView;
///// 是否选中
//@property (assign,nonatomic) BOOL wzIsSelect;
//
//@property (strong,nonatomic,readonly) UIButton *wzBadgeBtn; // 红点
//@property (strong,nonatomic,nullable) NSString *wzBadge;    // 红点内容
//@property (assign,nonatomic) CGSize wzItemSize;             // 设置宽高
//@property (assign,nonatomic) CGPoint wzBadgeCenterOffset;   // 红点位置
//
///// 显示红点
///// @param badgeValue 内容
///// @param point 内容类型
//- (void)showBadgeWith:(NSString * _Nullable)badgeValue withPoint:(CGPoint)point;
//
///// 清楚红点
//- (void)clearBadge;
//
///// 当前视图
//- (UIView *)getCurrentUITabBarButton;
//
///// 获取显示item图片view
//- (UIView * _Nullable)getTabBarSwappableImageView;
//
//@end


NS_ASSUME_NONNULL_END
