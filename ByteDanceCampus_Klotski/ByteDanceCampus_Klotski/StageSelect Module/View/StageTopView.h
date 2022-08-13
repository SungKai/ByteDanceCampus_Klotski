//
//  StageTopView.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - StageTopView

@interface StageTopView : UIView

/// 主视图，用来拉大
@property (nonatomic, readonly) UIView *contentView;

/// 标题（计算属性）
@property (nonatomic, copy) NSString *title;

/// 标题的底部
@property (nonatomic, readonly) CGFloat topBelowTitle;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
