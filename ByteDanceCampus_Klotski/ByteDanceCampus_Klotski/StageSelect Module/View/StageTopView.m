//
//  StageTopView.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/7.
//

#import "StageTopView.h"

#import <MMMarkdown.h>
#import <CocoaMarkdown/CocoaMarkdown.h>

#pragma mark - StageTopView ()

@interface StageTopView ()

/// 大标题
@property (nonatomic, strong) UILabel *nameLab;

/// 管理webView
@property (nonatomic, strong) UIView *introView;

/// 富文本
@property (nonatomic, strong) YYLabel *introduceLab;

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
        self.contentView.clipsToBounds = YES;
        
        [self.contentView addSubview:self.nameLab];
        
        [self.contentView addSubview:self.introView];
    }
    return self;
}

#pragma mark - Method

- (void)drawRect:(CGRect)rect {
//    self.contentView.height = rect.size.height;
}

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

- (UIView *)introView {
    if (_introView == nil) {
        _introView = [[UIView alloc] initWithFrame:CGRectMake(0, self.nameLab.bottom + 30, self.width, kScreenHeight)];
        _introView.backgroundColor =
        [UIColor Any_hex:@"#F8F9FC" a:1 Dark_hex:@"#000000" a:1];
        
        _introView.layer.cornerRadius = 30;
        _introView.clipsToBounds = YES;
    }
    return _introView;
}

- (YYLabel *)introduceLab {
    if (_introduceLab == nil) {
        _introduceLab = [[YYLabel alloc] initWithFrame:CGRectMake(15, 15, self.introView.width - 30, kScreenHeight)];
        CMDocument *document = [[CMDocument alloc] initWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"klotski" ofType:@"md"] options:CMDocumentOptionsSmart];
        NSAttributedString *string = [document attributedStringWithAttributes:[[CMTextAttributes alloc] init]];
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(_introduceLab.width, CGFLOAT_MAX) text:string];
        _introduceLab.textLayout = layout;
        _introduceLab.attributedText = string;
        _introduceLab.numberOfLines = 0;
    }
    return _introduceLab;
}

@end
