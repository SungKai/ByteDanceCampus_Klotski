//
//  LevelFuncView.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/17.
//

/**功能展示
 * 保存棋盘
 * 重新玩耍
 * 自动求解
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LevelFuncView;

#pragma mark - ENUM(LevelFuncType)

typedef NS_ENUM(NSUInteger, LevelFuncType) {
    LevelFuncTypeSaveCurrent, // 保存棋盘
    LevelFuncTypeResetPlay,   // 重新玩耍
    LevelFuncTypeAutoGame     // 自动求解
};

#pragma mark - LevelFuncViewDelegate

typedef void(^LevelFuncViewComplitionBlock)(BOOL);

@protocol LevelFuncViewDelegate <NSObject>

/// 是否允许执行功能
/// @param view 功能视图
/// @param type 功能
- (BOOL)levelFuncView:(LevelFuncView *)view enableToSelectTypeFunc:(LevelFuncType)type;

/// 执行功能回掉
/// @param view 功能视图
/// @param type 功能
- (void)levelFuncView:(LevelFuncView *)view didSelectTypeFunc:(LevelFuncType)type;

@end

#pragma mark - LevelFuncView

@interface LevelFuncView : UIView

/// 代理
@property (nonatomic, weak) id <LevelFuncViewDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
