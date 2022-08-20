//
//  TodayRecommendView.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TodayRecommendView : UIView

/// 标题
@property (nonatomic, copy) NSString *title;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

- (void)addTarget:(id)target action:(nonnull SEL)action;

@end

NS_ASSUME_NONNULL_END
