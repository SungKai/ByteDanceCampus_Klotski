//
//  IntroCell.m
//  ByteDanceCampus_Klotski
//
//  Created by TH on 8/10/22.
//

#import "IntroCell.h"
#import "Masonry.h"
#import <CocoaMarkdown/CocoaMarkdown.h>

@interface IntroCell ()

@property (nonatomic, strong) UIScrollView *introView;

@property (nonatomic, strong) YYLabel *introduceTextView;

@property (nonatomic) BOOL down;

@end

@implementation IntroCell

- (instancetype)init {
    self = [super init];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 30;
    [self addSubview: self.introView];
    [self.introView addSubview: self.introduceTextView];
    [self makeConstraint];
    return self;
}

- (YYLabel *)introduceTextView {
    if (_introduceTextView == nil) {
        _introduceTextView = [YYLabel new];
        _introduceTextView.font = [UIFont fontWithName:PingFangSC size:14];
        _introduceTextView.textColor =
        [UIColor Any_hex:@"#112C54" a:1 Dark_hex:@"#F0F0F0" a:1];
        _introduceTextView.numberOfLines = 0;
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

- (UIScrollView *)introView {
    if (_introView == nil) {
        _introView = [UIScrollView new];
        _introView.backgroundColor =
        [UIColor Any_hex:@"#F8F9FC" a:1 Dark_hex:@"#000000" a:1];
        _introView.showsVerticalScrollIndicator = YES;
        _introView.pagingEnabled = YES;
        _introView.showsVerticalScrollIndicator = YES;
    }
    return _introView;
}

- (void)makeConstraint {
    [self.introView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    
    [ self.introduceTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self).inset(10);
    }];
    
    self.introView.contentSize = CGSizeMake(self.introduceTextView.width, 300);
}

//- (void)drawRect:(CGRect)rect {
//    // rect是实际上contentView的视图
//    [self scrollWithContentOffset:CGPointMake(0, -rect.size.height + self.height)];
//
//    if (rect.size.height < 300) {
//        self.introView.hidden = YES;
//    } else if (rect.size.height < 335) {
//        self.introView.hidden = NO;
//        self.introView.alpha = (rect.size.height - 300) / 35;
//    }
//    if (rect.size.height > 400) {
//        self.introView.alpha = 1;
//    }
//    self.introView.top = self.contentView.top;
//    [self.introView stretchBottom_toPointY:self.contentView.SuperBottom offset:40];
//
//    self.introduceTextView.top = 15;
//    [self.introduceTextView stretchBottom_toPointY:self.introView.SuperBottom offset:15];
//}
//
//- (void)scrollWithContentOffset:(CGPoint)contentOffset {
//    static BOOL down = YES;
//    static CGFloat currentY = 0;
//    if (contentOffset.y < currentY) {
//        if (contentOffset.y <= -100 && down) {
//            UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
//            [generator impactOccurred];
//
//            down = NO;
//        }
//        self.down = YES;
//    } else {
//        if (contentOffset.y > -100 && !down) {
//            down = YES;
//        }
//        self.down = NO;
//    }
//    currentY = contentOffset.y;
//}



@end
