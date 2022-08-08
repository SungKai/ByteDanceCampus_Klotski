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

/// 用于加视图
@property (nonatomic, readonly) UIView *contentView;

/// 用于ScrollView操作（计算属性）
@property (nonatomic, readonly) UIScrollView *scrollView;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
