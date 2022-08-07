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
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.whiteColor;
        self.contentView.layer.cornerRadius = 30;
        
        [self.contentView addSubview:self.stageNameLab];
        [self.contentView addSubview:self.moveImgView];
        [self.contentView addSubview:self.bestStepLab];
        [self.contentView addSubview:self.collectImgView];
    }
    return self;
}

#pragma mark - Method

- (void)drawRect:(CGRect)rect {
    
    self.stageNameLab.width = rect.size.width;
    
    self.moveImgView.left = 30;
    self.moveImgView.bottom = rect.size.height - 20;
    
    self.bestStepLab.top = self.moveImgView.top;
    self.bestStepLab.left = self.moveImgView.right + 15;
    
    self.collectImgView.right = self.stageNameLab.right - 20;
    self.collectImgView.top = self.stageNameLab.top;
}

// MARK: SEL

#pragma mark - Getter

- (UILabel *)stageNameLab {
    if (_stageNameLab == nil) {
        _stageNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, self.contentView.width, 50)];
        _stageNameLab.textAlignment = NSTextAlignmentCenter;
        _stageNameLab.font = [UIFont fontWithName:PingFangSCBold size:36];
    }
    return _stageNameLab;
}

- (UIImageView *)moveImgView {
    if (_moveImgView == nil) {
        _moveImgView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 100, 50, 50)];
        _moveImgView.image = [UIImage imageNamed:@"move"];
    }
    return _moveImgView;
}

- (UILabel *)bestStepLab {
    if (_bestStepLab == nil) {
        _bestStepLab = [[UILabel alloc] initWithFrame:CGRectMake(95, 100, 200, 50)];
        _bestStepLab.font = [UIFont fontWithName:PingFangSC size:23];
    }
    return _bestStepLab;
}

- (UIImageView *)collectImgView {
    if (_collectImgView == nil) {
        _collectImgView = [[UIImageView alloc] initWithFrame:CGRectMake(284, 16, 30, 30)];
        _collectImgView.image = [UIImage imageNamed:@"uncollect"];
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
    if (bestStep) {
        self.moveImgView.image = [UIImage imageNamed:@"move"];
        self.bestStepLab.text = [NSString stringWithFormat:@"最佳记录：%ld", bestStep];
    } else {
        self.moveImgView.image = [UIImage imageNamed:@"game"];
        self.bestStepLab.text = @"还没有记录哟～";
    }
}

- (void)setIsCollect:(BOOL)isCollect {
    _isCollect = isCollect;
    self.collectImgView.image =
    [UIImage imageNamed:(isCollect ? @"collect" : @"uncollect")];
}

@end
