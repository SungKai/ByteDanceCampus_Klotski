//
//  StageSelectCell.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 复用标志
FOUNDATION_EXPORT NSString * StageSelectCellReuseIdentifier;

#pragma mark - StageSelectCell

@interface StageSelectCell : UITableViewCell

/// 关卡名（计算属性）
@property (nonatomic, copy) NSString *name;

/// 最佳步数（计算属性）
/// (负数：没玩过，非负数：正常显示)
@property (nonatomic) NSInteger bestStep;

/// 是否收藏
@property (nonatomic) BOOL isCollect;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
