//
//  PersonItem.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 复用标志
FOUNDATION_EXPORT NSString * PersonItemReuseIdentifier;

#pragma mark - PersonItem

@interface PersonItem : UICollectionViewCell

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

/// 名字（计算属性）
@property (nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
