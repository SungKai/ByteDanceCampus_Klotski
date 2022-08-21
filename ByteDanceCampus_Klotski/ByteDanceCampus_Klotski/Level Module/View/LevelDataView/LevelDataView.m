//
//  LevelDataView.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/21.
//

#import "LevelDataView.h"

#pragma mark - LevelDataView ()

@interface LevelDataView ()

/// 当前
@property (nonatomic, strong) UILabel *currentLab;

/// 最佳
@property (nonatomic, strong) UILabel *bestLab;

@end

#pragma mark - LevelDataView

@implementation LevelDataView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor Any_hex:@"#FDF5EC" a:1 Dark_hex:@"#FDF1F1" a:1];
        self.layer.borderColor = [UIColor Any_hex:@"#F7D6AA" a:1 Dark_hex:@"#F2C1BE" a:1].CGColor;
        self.layer.cornerRadius = self.height / 2;
        self.clipsToBounds = YES;
        [self addSubview:self.currentLab];
        [self addSubview:self.bestLab];
    }
    return self;
}

#pragma mark - Method

- (void)dataWithCurrentStep:(NSInteger)step bestStep:(NSInteger)best {
    self.currentLab.text = [NSString stringWithFormat:@"当前步数:%ld", step];
    self.bestLab.text = ((best <= 0) ?
                         @"还未成功通关哟～" :
                         [NSString stringWithFormat:@"最佳步数:%ld", best]);
}

- (void)dataWithCalculate {
    self.currentLab.text = @"正在计算解法中...";
    self.bestLab.text = @"正在计算解法所需步数...";
}

- (void)dataWithSolvingFinalStep:(NSInteger)finalStep {
    self.currentLab.text = @"自动求解中...";
    self.bestLab.text = [NSString stringWithFormat:@"所需步数:%ld", finalStep];
}

#pragma mark - Getter

- (UILabel *)currentLab {
    if (_currentLab == nil) {
        _currentLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.width / 2 - 10, self.height)];
        _currentLab.font = [UIFont fontWithName:PingFangSC size:17];
        _currentLab.textColor = [UIColor colorWithHexString:@"#112C54"];
    }
    return _currentLab;
}

- (UILabel *)bestLab {
    if (_bestLab == nil) {
        _bestLab = [[UILabel alloc] initWithFrame:CGRectMake(self.width / 2, 0, self.width / 2 - 10, self.height)];
        _bestLab.font = [UIFont fontWithName:PingFangSC size:17];
        _bestLab.textColor = [UIColor colorWithHexString:@"#112C54"];
    }
    return _bestLab;
}

@end
