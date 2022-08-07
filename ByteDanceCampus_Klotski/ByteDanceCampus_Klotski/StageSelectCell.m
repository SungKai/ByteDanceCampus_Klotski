//
//  StageSelectCell.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/6.
//

#import "StageSelectCell.h"

NSString * StageSelectCellReuseIdentifier = @"StageSelectCell";

#pragma mark - StageSelectCell ()

@interface StageSelectCell ()

/// 关卡名字
@property (nonatomic, strong) UILabel *stageNameLab;

/// 最佳步数图标
@property (nonatomic, strong) UIImageView *moveImgView;

/// 最佳步数
@property (nonatomic, strong) UILabel *bestStepLab;

/// 已收藏的标识
@property (nonatomic, strong) UIImageView *collectImgView;

@end

#pragma mark - StageSelectCell

@implementation StageSelectCell

#pragma mark - Life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.stageNameLab];
        [self.contentView addSubview:self.moveImgView];
        [self.contentView addSubview:self.bestStepLab];
        [self.contentView addSubview:self.collectImgView];
    }
    return self;
}

#pragma mark - Method

// MARK: SEL

#pragma mark - Getter

- (UILabel *)stageNameLab {
    if (_stageNameLab == nil) {
        _stageNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width - 20, 30)];
        _stageNameLab.font = [UIFont fontWithName:PingFangSC size:24];
    }
    return _stageNameLab;
}

- (UIImageView *)moveImgView {
    if (_moveImgView == nil) {
        _moveImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _moveImgView.image = [UIImage imageNamed:@"move"];
    }
    return _moveImgView;
}

- (UILabel *)bestStepLab {
    if (_bestStepLab == nil) {
        _bestStepLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 20)];
        _bestStepLab.font = [UIFont fontWithName:PingFangSCSemibold size:18];
    }
    return _bestStepLab;
}

- (UIImageView *)collectImgView {
    if (_collectImgView == nil) {
        _collectImgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, 20, 20)];
        _collectImgView.image = [UIImage imageNamed:@"collect"];
    }
    return _collectImgView;
}

#pragma mark - Getter calculate

- (NSString *)name {
    return self.stageNameLab.text;
}

- (NSInteger)bestStep {
    return self.bestStepLab.text.longValue;
}

#pragma mark - Setter

- (void)setName:(NSString *)name {
    self.stageNameLab.text = name;
}

- (void)setBestStep:(NSInteger)bestStep {
    self.bestStepLab.text = [NSString stringWithFormat:@"%ld", bestStep];
}

- (void)setIsCollect:(BOOL)isCollect {
    _isCollect = isCollect;
    
}

@end
