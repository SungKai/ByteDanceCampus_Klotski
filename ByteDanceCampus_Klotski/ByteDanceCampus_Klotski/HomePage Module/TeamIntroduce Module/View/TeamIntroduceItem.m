//
//  TeamIntroduceItem.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/13.
//

#import "TeamIntroduceItem.h"

NSString * TeamIntroduceItemReuseIdentifier = @"TeamIntroduceItem";

#pragma mark - TeamIntroduceItem ()

@interface TeamIntroduceItem ()

/// 标题
@property (nonatomic, strong) UILabel *titleLab;

/// 内容
@property (nonatomic, strong) UILabel *contentLab;

@end

#pragma mark - TeamIntroduceItem

@implementation TeamIntroduceItem

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor =
        [UIColor Any_hex:@"#F6F1FD" a:1 Dark_hex:@"F2FBF0" a:1];
        self.contentView.layer.cornerRadius = 20;
        self.contentView.layer.borderWidth = 2;
        self.contentView.layer.borderColor =
        [UIColor Any_hex:@"#C9B3F5" a:1 Dark_hex:@"#C2EAB6" a:1].CGColor;
        
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.contentLab];
    }
    return self;
}

#pragma mark - Method

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    CGRect frame = layoutAttributes.frame;
    [self.titleLab stretchRight_toPointX:frame.size.width offset:7];
    
    self.contentLab.top = self.titleLab.bottom + 3;
    self.contentLab.width = self.titleLab.width;
}

- (void)title:(NSString *)title content:(NSString *)content {
    self.titleLab.text = title;
    self.contentLab.text = content;
}

#pragma mark - Getter

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, 0, 30)];
        _titleLab.font = [UIFont fontWithName:PingFangSCBold size:14];
        _titleLab.textColor = [UIColor colorWithHexString:@"#112C54"];
    }
    return _titleLab;
}

- (UILabel *)contentLab {
    if (_contentLab == nil) {
        _contentLab = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLab.left, 0, 0, 20)];
        _contentLab.font = [UIFont fontWithName:PingFangSC size:10];
        _contentLab.textColor = [UIColor colorWithHexString:@"#112C54"];
    }
    return _contentLab;
}

@end
