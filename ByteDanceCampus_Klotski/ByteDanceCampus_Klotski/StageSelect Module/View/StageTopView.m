//
//  StageTopView.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/7.
//

#import "StageTopView.h"

#import <CocoaMarkdown/CocoaMarkdown.h>

#pragma mark - StageTopView ()

@interface StageTopView ()

/// 大标题
@property (nonatomic, strong) UILabel *nameLab;

/// 富文本
@property (nonatomic, strong) YYTextView *introduceTextView;

@end

#pragma mark - StageTopView

@implementation StageTopView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.down = YES;
        self.backgroundColor = UIColor.clearColor;
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.backgroundColor = UIColor.clearColor;
        [self addSubview:_contentView];
        self.contentView.clipsToBounds = YES;
        [self.contentView addSubview:self.nameLab];
    }
    return self;
}

#pragma mark - Method

// MARK: SEL

#pragma mark - Getter

- (UILabel *)nameLab {
    if (_nameLab == nil) {
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, UIDevice.safeDistanceTop + 15, self.width, 0.6 * self.height)];
        _nameLab.text = @"华容道";
        _nameLab.font = [UIFont fontWithName:PingFangSCBold size:58];
        _nameLab.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLab;
}

@end
