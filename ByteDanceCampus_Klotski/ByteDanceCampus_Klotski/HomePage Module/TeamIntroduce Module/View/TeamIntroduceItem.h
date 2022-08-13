//
//  TeamIntroduceItem.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 复用标志
FOUNDATION_EXPORT NSString * TeamIntroduceItemReuseIdentifier;

#pragma mark - TeamIntroduceItem

@interface TeamIntroduceItem : UICollectionViewCell

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

/// 绘制视图里面内容
/// @param title 绘制标题
/// @param content 绘制内容
- (void)title:(NSString *)title content:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
