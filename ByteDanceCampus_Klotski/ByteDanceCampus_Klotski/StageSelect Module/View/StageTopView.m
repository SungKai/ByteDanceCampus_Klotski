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

// MARK: SEL

#pragma mark - Getter

- (UILabel *)nameLab {
    if (_nameLab == nil) {
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, UIDevice.statusBarHeight, self.width, 80)];
        _nameLab.font = [UIFont fontWithName:PingFangSCBold size:58];
        _nameLab.textAlignment = NSTextAlignmentCenter;
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

//- (UIView *)introView {
//    if (_introView == nil) {
//        _introView = [[UIView alloc] initWithFrame:CGRectMake(0, self.nameLab.bottom + 30, self.width, kScreenHeight)];
//        _introView.backgroundColor =
//        [UIColor Any_hex:@"#F8F9FC" a:1 Dark_hex:@"#000000" a:1];
//        _introView.layer.cornerRadius = 30;
//    }
//    return _introView;
//}
//
//- (YYTextView *)introduceTextView {
//    if (_introduceTextView == nil) {
//        _introduceTextView = [[YYTextView alloc] initWithFrame:CGRectMake(15, 15, self.introView.width - 30, 0)];
//        _introduceTextView.font = [UIFont fontWithName:PingFangSC size:14];
////        _introduceTextView.textColor = UIColor.redColor;
//////        [UIColor Any_hex:@"#112C54" a:1 Dark_hex:@"#F0F0F0" a:1];
//
//        dispatch_async(dispatch_queue_create("Rising & SSR.ByteDance.StageTopView", DISPATCH_QUEUE_CONCURRENT), ^{
//            CMDocument *document = [[CMDocument alloc] initWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"klotski" ofType:@"md"] options:15];
//            NSAttributedString *string = [document attributedStringWithAttributes:[[CMTextAttributes alloc] init]];
//            dispatch_sync(dispatch_get_main_queue(), ^{
//                self->_introduceTextView.attributedText = string;
//            });
//        });
//    }
//    return _introduceTextView;
//}

@end
