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

/// 管理webView
@property (nonatomic, strong) UIView *introView;

/// 富文本
@property (nonatomic, strong) YYTextView *introduceTextView;

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
        
        [self.contentView addSubview:self.introView]; {
            [self.introView addSubview:self.introduceTextView];
        }
    }
    return self;
}

#pragma mark - Method

- (void)drawRect:(CGRect)rect {
    // rect是实际上contentView的视图
    [self scrollWithContentOffset:CGPointMake(0, -rect.size.height + self.height)];
    
    if (rect.size.height < 300) {
        self.introView.hidden = YES;
    } else if (rect.size.height < 335) {
        self.introView.hidden = NO;
        self.introView.alpha = (rect.size.height - 300) / 35;
    }
    if (rect.size.height > 400) {
        self.introView.alpha = 1;
    }
    self.introView.top = self.nameLab.bottom + 15;
    [self.introView stretchBottom_toPointY:self.contentView.SuperBottom offset:40];
    
    self.introduceTextView.top = 15;
    [self.introduceTextView stretchBottom_toPointY:self.introView.SuperBottom offset:15];
}

- (void)scrollWithContentOffset:(CGPoint)contentOffset {
    static BOOL down = YES;
    static CGFloat currentY = 0;
    if (contentOffset.y < currentY) {
        if (contentOffset.y <= -100 && down) {
            UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
            [generator impactOccurred];
            
            down = NO;
        }
    } else {
        if (contentOffset.y > -100 && !down) {
            down = YES;
        }
    }
    currentY = contentOffset.y;
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
    }
    return _introView;
}

- (YYTextView *)introduceTextView {
    if (_introduceTextView == nil) {
        _introduceTextView = [[YYTextView alloc] initWithFrame:CGRectMake(15, 15, self.introView.width - 30, 0)];
        _introduceTextView.font = [UIFont fontWithName:PingFangSC size:14];
        _introduceTextView.textColor =
        [UIColor Any_hex:@"#112C54" a:1 Dark_hex:@"#F0F0F0" a:1];
        
        dispatch_async(dispatch_queue_create("Rising & SSR.ByteDance.StageTopView", DISPATCH_QUEUE_CONCURRENT), ^{
            CMDocument *document = [[CMDocument alloc] initWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"klotski" ofType:@"md"] options:15];
            NSAttributedString *string = [document attributedStringWithAttributes:[[CMTextAttributes alloc] init]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                self->_introduceTextView.attributedText = string;
            });
        });
    }
    return _introduceTextView;
}

- (UIScrollView *)scrollView {
    return self.introduceTextView;
}

@end
