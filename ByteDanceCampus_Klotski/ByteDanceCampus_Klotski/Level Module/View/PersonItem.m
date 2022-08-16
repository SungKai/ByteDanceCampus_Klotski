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

/// 名字
@property (nonatomic, strong) UILabel *nameLab;

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
//        [self.contentView addSubview:self.perImgView];
        
        [self.contentView addSubview:self.nameLab];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    CGRect rect = layoutAttributes.frame;
    self.perImgView.size = rect.size;
    
    self.nameLab.top = 0;
    self.nameLab.width = rect.size.width;
    self.nameLab.height = 50;
}

#pragma mark - Method

// MARK: SEL

#pragma mark - Getter

- (UILabel *)nameLab {
    if (_nameLab == nil) {
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, 50)];
        _nameLab.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLab;
}

- (UIImageView *)perImgView {
    if (_perImgView == nil) {
        _perImgView = [[UIImageView alloc] init];
    }
    return _perImgView;
}

- (NSString *)name {
    return self.nameLab.text;
}

#pragma mark - Setter

- (void)setName:(NSString *)name {
    self.nameLab.text = name;
    self.perImgView.image = [UIImage imageNamed:name];
}

@end
