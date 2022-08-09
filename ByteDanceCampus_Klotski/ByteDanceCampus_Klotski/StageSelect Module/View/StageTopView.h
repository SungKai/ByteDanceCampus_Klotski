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

/// 伸缩情况
@property (nonatomic) BOOL down;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
