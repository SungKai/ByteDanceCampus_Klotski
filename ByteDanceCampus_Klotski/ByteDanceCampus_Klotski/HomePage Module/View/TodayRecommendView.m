//
//  TodayRecommendView.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/20.
//

#import "TodayRecommendView.h"

#pragma mark - TodayRecommendView ()

@interface TodayRecommendView ()

/// @"今日推荐“
@property (nonatomic, strong) UILabel *todayLab;

/// 推荐的Lab
@property (nonatomic, strong) UILabel *recommendLab;

/// 单击
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

#pragma mark - TodayRecommendView

@implementation TodayRecommendView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 20;
        self.clipsToBounds = YES;
        self.backgroundColor =
        [UIColor Any_hex:@"#F8F9FC" a:1 Dark_hex:@"#000000" a:1];
        
        [self addSubview:self.todayLab];
        [self addSubview:self.recommendLab];
        
        self.tap = [[UITapGestureRecognizer alloc] init];
        [self addGestureRecognizer:self.tap];
    }
    return self;
}

#pragma mark - Method

- (void)addTarget:(id)target action:(SEL)action {
    [self.tap addTarget:target action:action];
}

// MARK: SEL

#pragma mark - Getter

- (UILabel *)todayLab {
    if (_todayLab == nil) {
        _todayLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5 * self.height)];
        _todayLab.backgroundColor = UIColor.clearColor;
        _todayLab.textAlignment = NSTextAlignmentCenter;
        _todayLab.font = [UIFont fontWithName:PingFangSCBold size:24];
        _todayLab.textColor = [UIColor Any_hex:@"#112C54" a:1 Dark_hex:@"#F0F0F0" a:1];
        _todayLab.text = @"今日推荐";
    }
    return _todayLab;
}

- (UILabel *)recommendLab {
    if (_recommendLab == nil) {
        _recommendLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.3 * self.height, self.width, 0.7 * self.height)];
        _recommendLab.backgroundColor = UIColor.clearColor;
        _recommendLab.textAlignment = NSTextAlignmentCenter;
        _recommendLab.font = [UIFont fontWithName:PangMenZhengDaoBold size:68];
        _recommendLab.textColor = [UIColor Any_hex:@"#112C54" a:1 Dark_hex:@"#F0F0F0" a:1];
    }
    return _recommendLab;
}

- (NSString *)title {
    return self.recommendLab.text.copy;
}

#pragma mark - Setter

- (void)setTitle:(NSString *)title {
    self.recommendLab.text = title.copy;
}

@end
