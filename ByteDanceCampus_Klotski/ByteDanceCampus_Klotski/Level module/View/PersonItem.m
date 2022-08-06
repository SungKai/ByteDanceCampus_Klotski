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

@end

#pragma mark - PersonItem

@implementation PersonItem

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.orangeColor;
        [self.contentView addSubview:self.nameLab];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    CGRect rect = layoutAttributes.frame;
    self.nameLab.bottom = rect.size.height;
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

- (NSString *)name {
    return self.nameLab.text;
}

#pragma mark - Setter

- (void)setName:(NSString *)name {
    self.nameLab.text = name;
}

@end
