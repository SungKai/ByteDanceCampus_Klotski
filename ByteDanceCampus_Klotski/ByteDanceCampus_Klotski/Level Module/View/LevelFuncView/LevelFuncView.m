//
//  LevelFuncView.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/17.
//

#import "LevelFuncView.h"

#pragma mark - LevelFuncView ()

@interface LevelFuncView ()

/// 保存棋局
@property (nonatomic, strong) UIButton *saveBtn;

/// 重新玩耍
@property (nonatomic, strong) UIButton *resetBtn;

/// 自动求解
@property (nonatomic, strong) UIButton *autoBtn;

@end

#pragma mark - LevelFuncView

@implementation LevelFuncView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        [self addSubview:self.saveBtn];
        [self addSubview:self.resetBtn];
        [self addSubview:self.autoBtn];
    }
    return self;
}

#pragma mark - Method

- (void)__didSelectBtn:(UIButton *)btn {
    LevelFuncType type = LevelFuncTypeSaveCurrent;
    if ([btn.titleLabel.text isEqualToString:@"保存棋局"]) {
        type = LevelFuncTypeSaveCurrent;
    } else if ([btn.titleLabel.text isEqualToString:@"重新挑战"]) {
        type = LevelFuncTypeResetPlay;
    } else if ([btn.titleLabel.text isEqualToString:@"自动求解"]) {
        type = LevelFuncTypeAutoGame;
    }
    
    if (self.delegate) {
        if ([self.delegate levelFuncView:self enableToSelectTypeFunc:type]) {
            [self.delegate levelFuncView:self didSelectTypeFunc:type];
        }
    }
}

#pragma mark - Getter

- (UIButton *)saveBtn {
    if (_saveBtn == nil) {
        _saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, self.height)];
        _saveBtn.layer.cornerRadius = _saveBtn.height / 2;
        _saveBtn.layer.borderWidth = 2;
        _saveBtn.layer.borderColor = [UIColor Any_hex:@"#F7D6AA" a:1 Dark_hex:@"#F2C1BE" a:1].CGColor;
        _saveBtn.backgroundColor = [UIColor Any_hex:@"#FDF5EC" a:1 Dark_hex:@"#FDF1F1" a:1];
        
        [_saveBtn setTitle:@"保存棋局" forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = [UIFont fontWithName:PingFangSC size:24];
        [_saveBtn setTitleColor:[UIColor colorWithHexString:@"#112C54"] forState:UIControlStateNormal];
        
        [_saveBtn addTarget:self action:@selector(__didSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

- (UIButton *)resetBtn {
    if (_resetBtn == nil) {
        _resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, self.height)];
        _resetBtn.centerX = self.width / 2;
        _resetBtn.layer.cornerRadius = _resetBtn.height / 2;
        _resetBtn.layer.borderWidth = 2;
        _resetBtn.layer.borderColor = [UIColor Any_hex:@"#F7D6AA" a:1 Dark_hex:@"#F2C1BE" a:1].CGColor;
        _resetBtn.backgroundColor = [UIColor Any_hex:@"#FDF5EC" a:1 Dark_hex:@"#FDF1F1" a:1];
        
        [_resetBtn setTitle:@"重新挑战" forState:UIControlStateNormal];
        _resetBtn.titleLabel.font = [UIFont fontWithName:PingFangSC size:24];
        [_resetBtn setTitleColor:[UIColor colorWithHexString:@"#112C54"] forState:UIControlStateNormal];
        
        [_saveBtn addTarget:self action:@selector(__didSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetBtn;
}

- (UIButton *)autoBtn {
    if (_autoBtn == nil) {
        _autoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, self.height)];
        _autoBtn.right = self.SuperRight;
        _autoBtn.layer.cornerRadius = _autoBtn.height / 2;
        _autoBtn.layer.borderWidth = 2;
        _autoBtn.layer.borderColor = [UIColor Any_hex:@"#F7D6AA" a:1 Dark_hex:@"#F2C1BE" a:1].CGColor;
        _autoBtn.backgroundColor = [UIColor Any_hex:@"#FDF5EC" a:1 Dark_hex:@"#FDF1F1" a:1];
        
        [_autoBtn setTitle:@"自动求解" forState:UIControlStateNormal];
        _autoBtn.titleLabel.font = [UIFont fontWithName:PingFangSC size:24];
        [_autoBtn setTitleColor:[UIColor colorWithHexString:@"#112C54"] forState:UIControlStateNormal];
        
        [_autoBtn addTarget:self action:@selector(__didSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _autoBtn;
}

@end
