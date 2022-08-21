//
//  LevelAdapter.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/5.
//

#import "LevelAdapter.h"

#import "Level.h"

#import "PersonItem.h"

#import "LevelDataView.h"

#pragma mark - LevelAdapter ()

@interface LevelAdapter ()

/// 华容道CollectionView
@property (nonatomic, strong) UICollectionView *collectionView;

/// 华容道布局（CollectionView已经强持有）
@property (nonatomic, weak) LevelCollectionLayout *layout;

/// 华容道的一局的信息
@property (nonatomic, strong) Level *model;

// MARK: - slove

/// 是否再自动求解
@property (nonatomic) BOOL isAutoSolve;

/// 解法
@property (nonatomic, strong) NSArray <NSDictionary <NSNumber *, NSNumber *> * > *solveSteps;

/// 当前步骤
@property (nonatomic) NSInteger currentSoloveStep;

@end

#pragma mark - LevelAdapter

@implementation LevelAdapter

#pragma mark - Life cycle

+ (instancetype)adapterWithCollectionView:(UICollectionView *)view layout:(nonnull LevelCollectionLayout *)layout model:(nonnull Level *)model {
    LevelAdapter *adapter = [[LevelAdapter alloc] init];
    adapter.collectionView = view;
    view.dataSource = adapter;
    view.delegate = adapter;
    
    UISwipeGestureRecognizer *panU = [[UISwipeGestureRecognizer alloc] initWithTarget:adapter action:@selector(_panItem:)];
    panU.direction = UISwipeGestureRecognizerDirectionUp;
    
    UISwipeGestureRecognizer *panR = [[UISwipeGestureRecognizer alloc] initWithTarget:adapter action:@selector(_panItem:)];
    panR.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *panD = [[UISwipeGestureRecognizer alloc] initWithTarget:adapter action:@selector(_panItem:)];
    panD.direction = UISwipeGestureRecognizerDirectionDown;
    
    UISwipeGestureRecognizer *panL = [[UISwipeGestureRecognizer alloc] initWithTarget:adapter action:@selector(_panItem:)];
    panL.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [view addGestureRecognizer:panU];
    [view addGestureRecognizer:panR];
    [view addGestureRecognizer:panD];
    [view addGestureRecognizer:panL];
    
    adapter.model = model;
    
    adapter.layout = layout;
    layout.delegate = adapter;
    return adapter;
}

#pragma mark - Method

- (void)_panItem:(UISwipeGestureRecognizer *)swipe {
    if (self.isAutoSolve) {
        return;
    }
    
    CGPoint point = [swipe locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    if (!indexPath) {
        return;
    }
    NSInteger index = indexPath.item;
    
    for (int i = 0; i < 4; i++) {
        if ((swipe.direction & (1 << i)) &&
            [self.model currentPersonAtIndex:index canMoveToDirection:i]) {
            
            [self.model currentPersonAtIndex:index moveTo:i];
            [self.layout moveItemAtIndex:index toDirection:i finished:nil];
            
            self.model.currentStep += 1;
            [self.dataView dataWithCurrentStep:self.model.currentStep bestStep:self.model.bestStep];
        }
    }
    
    if (self.model.isGameOver) {
        [self.model resetLayout];
        self.model.currentStep = 0;
        [self.model updateDB];
    }
}

#pragma mark - Setter

- (void)setDataView:(LevelDataView *)dataView {
    _dataView = dataView;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.personAry.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PersonItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PersonItemReuseIdentifier forIndexPath:indexPath];
    
    Person *model = self.model.personAry[indexPath.item];
    NSString *str =
    (model.width == model.height ?
     model.name :
     [NSString stringWithFormat:@"%@.%@", model.name,
      (model.width == (model.height * 2) ? @"H" : @"V")]);
    
    cell.name = str;
    
    return cell;
}

#pragma mark - <LevelCollectionLayoutDelegate>

- (PersonFrame)collectionView:(UICollectionView *)collectionView layout:(LevelCollectionLayout *)layout frameForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.model.personAry[indexPath.item].frame;
}

#pragma mark - <LevelFuncViewDelegate>

- (BOOL)levelFuncView:(nonnull LevelFuncView *)view enableToSelectTypeFunc:(LevelFuncType)type {
    return !self.isAutoSolve;
}

- (void)levelFuncView:(nonnull LevelFuncView *)view didSelectTypeFunc:(LevelFuncType)type {
    switch (type) {
        case LevelFuncTypeSaveCurrent: {
            [self.model updateDB];
        } break;
            
        case LevelFuncTypeResetPlay: {
            
            [self.model resetLayout];
            self.model.currentStep = 0;
            [self.dataView dataWithCurrentStep:self.model.currentStep bestStep:self.model.bestStep];
            [self.collectionView performBatchUpdates:^{
                [self.layout reloadLayout];
            } completion:nil];
            
        } break;
            
        case LevelFuncTypeAutoGame:{
            
            [self.dataView dataWithCalculate];
            self.isAutoSolve = YES;
            self.solveSteps = self.model.stepForCurrent;
            
            [self.dataView dataWithSolvingFinalStep:self.solveSteps.count];
            [self _solveDic:self._nextStep];
            
        } break;
    }
}
    
#pragma mark - property method

- (void)_solveDic:(NSDictionary <NSNumber *, NSNumber *> *)dic {
    if (dic == nil) {
        return;
    }
    [self.layout
     moveItemAtIndex:(NSInteger)dic.allKeys[0]
     toDirection:(PersonDirection)dic.allValues[0]
     finished:^{
        [self _solveDic:self._nextStep];
    }];
}

- (NSDictionary <NSNumber *, NSNumber *> *)_nextStep {
    if (self.currentSoloveStep >= self.solveSteps.count) {
        return nil;
    }
    NSDictionary <NSNumber *, NSNumber *> *dic = self.solveSteps[self.currentSoloveStep];
    self.currentSoloveStep += 1;
    return dic;
}

@end
