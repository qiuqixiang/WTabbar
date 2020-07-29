//
//  WTabBar.m
//  WTabBar
//
//  Created by qiuqixiang on 2019/12/18.
//  Copyright © 2019 我主良缘. All rights reserved.
//

#import "WTabBar.h"
#import <objc/runtime.h>

@implementation WTabBar

- (void)setSelectedItem:(UITabBarItem *)selectedItem {
    [super setSelectedItem:selectedItem];
    
    /// 如果已经选中了就无需再更新了，过滤回调2次的操作
    if (selectedItem.wzIsSelect) {
        return;
    }
    
    for (UITabBarItem *itemA in self.items) {
        itemA.wzIsSelect = selectedItem != itemA ? NO:YES;
        if (itemA.wzCustomView) {
            [itemA.wzCustomView uploadSelectItem:itemA.wzIsSelect];
            UIView *swappableImageView = [itemA getTabBarSwappableImageView];
            swappableImageView.hidden = !itemA.wzCustomView.contentView.hidden;
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.hidden && self.userInteractionEnabled && self.alpha == 1) {
        for (UITabBarItem *itemA in self.items) {
            if (itemA.wzCustomView) {
                UIView *view = itemA.wzCustomView.contentView;
                CGPoint xxx = [self convertPoint:point toView:view];
                if ([view pointInside:xxx withEvent:event]) {
                    return view.superview;
                }
            }
        }
    }
    return [super hitTest:point withEvent:event];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (int i = 0; i<self.items.count; i++) {
           UITabBarItem *item0 = self.items[i == 0 ? i: i-1];
           UITabBarItem *item = self.items[i];
           UIView *tabBarButton = [item getCurrentUITabBarButton];
           CGRect tabBarButtonFrame = tabBarButton.frame;
           CGFloat y = item.wzItemSize.height > tabBarButtonFrame.size.height ? (tabBarButtonFrame.size.height - item.wzItemSize.height):tabBarButtonFrame.origin.y;
           tabBarButtonFrame.origin.x = i == 0 ? 0:CGRectGetMaxX(item0.getCurrentUITabBarButton.frame);
           tabBarButtonFrame.origin.y = y;
           tabBarButtonFrame.size.width = item.wzItemSize.width>0?item.wzItemSize.width:[self getAverageItemWith];
           tabBarButtonFrame.size.height = item.wzItemSize.height>0?item.wzItemSize.height:tabBarButtonFrame.size.height;
           tabBarButton.frame = tabBarButtonFrame;
           
           if (item.wzCustomView) {
              [tabBarButton insertSubview:item.wzCustomView.contentView atIndex:0];
               item.wzCustomView.contentView.frame = tabBarButton.bounds;
           }
                  
           /// 添加红点
           [self addSubview:item.wzBadgeBtn];
           /// 刷新一下位置
           if (!item.wzBadgeBtn.hidden) {
               item.wzBadgeCenterOffset = item.wzBadgeCenterOffset;
           }
       }
}

/// 获取item的with 非自定义
- (CGFloat)getAverageItemWith{
    CGFloat with = 0;
    NSInteger index = 0;
    for (UITabBarItem *item in self.items) {
        if (item.wzItemSize.width>0) {
            with+= item.wzItemSize.width;
            index ++;
        }
    }
    NSInteger num = self.items.count - index;
    return  (self.frame.size.width - with)/num;
}

@end

@implementation UITabBarItem (WZCustom)

+ (UITabBarItem *)initWithTitle:(NSString * _Nullable)title image:(UIImage * _Nullable)image customItem:(id<UITabBarItemProtocol> _Nullable)customView {
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:nil];
    item.wzCustomView = customView;
    return item;
}

+ (UITabBarItem *)initWithCustomItem:(id<UITabBarItemProtocol> _Nullable)customView {
    return [self initWithTitle:nil image:nil customItem:customView];
}

- (id<UITabBarItemProtocol>)wzCustomView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setWzCustomView:(id<UITabBarItemProtocol>)wzCustomView {
    objc_setAssociatedObject(self, @selector(wzCustomView), wzCustomView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)wzIsSelect {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setWzIsSelect:(BOOL)isSelect {
    objc_setAssociatedObject(self, @selector(wzIsSelect), @(isSelect), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)wzBadgeBtn {
    UIButton *btn = objc_getAssociatedObject(self, _cmd);
    if (btn == nil) {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitleColor:UIColor.whiteColor forState:0];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.layer.masksToBounds = YES;
        btn.hidden = YES;
        objc_setAssociatedObject(self, _cmd, btn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return btn;
}


- (NSString *)wzBadge {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setWzBadge:(NSString *)badge {
    objc_setAssociatedObject(self, @selector(wzBadge), badge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.wzBadgeBtn setTitle:badge forState:0];
}

- (CGSize)wzItemSize {
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj != nil && [obj isKindOfClass:[NSDictionary class]] && [obj count] == 2) {
           CGFloat with = [obj[@"with"] floatValue];
           CGFloat height = [obj[@"height"] floatValue];
           return CGSizeMake(with, height);
       } else
           return CGSizeZero;
}

- (void)setWzItemSize:(CGSize)itemSize {
    NSDictionary *cenerInfo = @{@"with" : @(itemSize.width), @"height" : @(itemSize.height)};
    objc_setAssociatedObject(self, @selector(wzItemSize), cenerInfo, OBJC_ASSOCIATION_RETAIN);
}

- (CGPoint)wzBadgeCenterOffset
{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj != nil && [obj isKindOfClass:[NSDictionary class]] && [obj count] == 2) {
        CGFloat x = [obj[@"x"] floatValue];
        CGFloat y = [obj[@"y"] floatValue];
        return CGPointMake(x, y);
    } else
        return CGPointZero;
}

- (void)setWzBadgeCenterOffset:(CGPoint)badgeCenterOff
{
    NSDictionary *cenerInfo = @{@"x" : @(badgeCenterOff.x), @"y" : @(badgeCenterOff.y)};
    objc_setAssociatedObject(self, @selector(wzBadgeCenterOffset), cenerInfo, OBJC_ASSOCIATION_RETAIN);
    
    CGRect tabBarButtonFrame = [self getCurrentUITabBarButton].frame;
    CGSize size = [self.wzBadgeBtn.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    size.height = 18;
    size.width = MAX(18.0, size.width+10);
    CGFloat maxWith = UIScreen.mainScreen.bounds.size.width/[self getTabbar].items.count/2;
    if (size.width>maxWith) {
        size.width = maxWith;
    }
    
    CGRect frame = self.wzBadgeBtn.frame;
    frame.origin.y = badgeCenterOff.y;
    if (self.wzBadge == nil) {
        size.width = 8;
        size.height = 8;
        frame.origin.x = 8 + badgeCenterOff.x + tabBarButtonFrame.origin.x + [self getCurrentUITabBarButton].frame.size.width/2;
    }else{
        frame.origin.x = 2 + badgeCenterOff.x + tabBarButtonFrame.origin.x + [self getCurrentUITabBarButton].frame.size.width/2;
    }
    frame.size = size;
    self.wzBadgeBtn.frame = frame;
    self.wzBadgeBtn.layer.cornerRadius = self.wzBadgeBtn.frame.size.height/2;
}


/// 显示红点
- (void)showBadgeWith:(NSString * _Nullable)badgeValue withPoint:(CGPoint)point {
    
    self.wzBadge = badgeValue;
    self.wzBadgeCenterOffset = point;
    self.wzBadgeBtn.hidden = NO;
}

/// 清楚红点
- (void)wzClearBadge {
    self.wzBadgeBtn.hidden = YES;
}


/// 获取当前视图的tabbar
- (UITabBar *)getTabbar {
    return (UITabBar *)[self getCurrentUITabBarButton].superview;
}

/// 当前视图
- (UIView *)getCurrentUITabBarButton {
    return [self valueForKeyPath:@"_view"];
}

- (UIView *)getVibrancyEffectView {
    return [self findWith:@"_vibrancyEffectView"];
}

/// 获取显示图层
- (UIView *)getTabBarSwappableImageView {
    return [self findWith:@"UITabBarSwappableImageView"];;
}

/// 根据名称寻找对应的view
- (UIView *)findWith:(NSString *)key {
    __block UIView *targetView = nil;
    [[self getCurrentUITabBarButton].subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([subview isKindOfClass:NSClassFromString(key)]) {
            targetView = subview;
            *stop = YES;
        }
    }];
    return targetView;
}

@end
