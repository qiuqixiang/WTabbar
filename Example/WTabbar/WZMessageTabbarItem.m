//
//  WZMessageTabbarItem.m
//  WZTabbar
//
//  Created by 牛胖胖 on 2019/12/10.
//  Copyright © 2019 我主良缘. All rights reserved.
//

#import "WZMessageTabbarItem.h"
//#import "LOTAnimationView.h"
@interface WZMessageTabbarItem ()

//@property (strong,nonatomic) LOTAnimationView *animationView; // 点击动画json

@end
@implementation WZMessageTabbarItem

//- (LOTAnimationView *)animationView {
//    if (!_animationView) {
//        _animationView = [LOTAnimationView new];
//        _animationView.cacheEnable = NO;
//        _animationView.userInteractionEnabled = NO;
//        _animationView.backgroundColor = [UIColor whiteColor];
//    }return _animationView;
//}

- (instancetype)initWith:(NSString *)json{
    if (self = [super init]) {
//        self.userInteractionEnabled = NO;
//        [self addSubview:self.animationView];
//        self.animationView.frame = CGRectMake(0, 0, 25, 25);
//        [self.animationView setAnimation:json];
        
    }return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.animationView.center = self.center;
    self.backgroundColor = [UIColor orangeColor];
}

/// 获取当前视图
- (UIView *_Nonnull)contentView{
    return self;
}

/// 告诉自定义视图当前是否被选中
/// @param isSelect 是否被选中
- (void)uploadSelectItem:(BOOL)isSelect {
//    self.backgroundColor = isSelect ?[UIColor orangeColor]:[UIColor blueColor];
    self.hidden = !isSelect;
//    [self.animationView play];
//    self.animationView.backgroundColor = [UIColor redColor];
}



@end
