//
//  StageTopView.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/7.
//

#import "StageTopView.h"

#pragma mark - StageTopView ()

@interface StageTopView ()

/// 大标题
@property (nonatomic, strong) UILabel *nameLab;

@end

#pragma mark - StageTopView

@implementation StageTopView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.backgroundColor = UIColor.clearColor;
        [self addSubview:_contentView];
        
        [self.contentView addSubview:self.nameLab];
    }
    return self;
}

#pragma mark - Getter

- (UILabel *)nameLab {
    if (_nameLab == nil) {
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, UIDevice.statusBarHeight, self.width, 100)];
        _nameLab.font = [UIFont fontWithName:PangMenZhengDaoBold size:93];
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.textColor =
        [UIColor Any_hex:@"#5A1F0A" a:1 Dark_hex:@"#C94823" a:1];
    }
    return _nameLab;
}

- (NSString *)title {
    return self.nameLab.text;
}

- (CGFloat)topBelowTitle {
    return self.nameLab.bottom;
}

#pragma mark - Setter

- (void)setTitle:(NSString *)title {
    self.nameLab.text = title;
}

@end
