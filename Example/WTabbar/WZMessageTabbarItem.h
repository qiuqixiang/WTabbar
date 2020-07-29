//
//  WZMessageTabbarItem.h
//  WZTabbar
//
//  Created by 牛胖胖 on 2019/12/10.
//  Copyright © 2019 我主良缘. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITabBar+WZCustom.h"
NS_ASSUME_NONNULL_BEGIN

@interface WZMessageTabbarItem : UIView <UITabBarItemProtocol>

- (instancetype)initWith:(NSString *)json;

@end

NS_ASSUME_NONNULL_END
