//
//  PersonItem.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

#import "PersonItem.h"

NSString * PersonItemReuseIdentifier = @"PersonItem";

#pragma mark - PersonItem ()

@interface PersonItem ()

/// 图片
@property (nonatomic, strong) UIImageView *perImgView;

@end

#pragma mark - PersonItem

@implementation PersonItem

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.orangeColor;
        self.contentView.layer.cornerRadius = 17;
        self.contentView.clipsToBounds = YES;
        [self.contentView addSubview:self.perImgView];
        
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    CGRect rect = layoutAttributes.frame;
    self.perImgView.size = rect.size;
}

#pragma mark - Getter

- (UIImageView *)perImgView {
    if (_perImgView == nil) {
        _perImgView = [[UIImageView alloc] init];
    }
    return _perImgView;
}

#pragma mark - Setter

- (void)setName:(NSString *)name {
    self.perImgView.image = [UIImage imageNamed:name];
}

@end
