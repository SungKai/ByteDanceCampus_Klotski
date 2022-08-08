//
//  StageSelectAdapter.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/7.
//

#import "StageSelectAdapter.h"

#import "StageSelectModel.h"

#import "StageSelectCell.h"

#import "StageTopView.h"

#pragma mark - StageSelectAdapter ()

@interface StageSelectAdapter ()

/// 视图
@property (nonatomic, strong) UITableView *tableView;

/// 模型
@property (nonatomic, strong) StageSelectModel *model;

/// VC
@property (nonatomic, weak) UIViewController *controller;

@end

#pragma mark - StageSelectAdapter

@implementation StageSelectAdapter

#pragma mark - Life cycle

+ (instancetype)adapterWithController:(UIViewController *)controller
                            tableView:(UITableView *)tableview
                                model:(StageSelectModel *)model {
    
    StageSelectAdapter *adapter = [[StageSelectAdapter alloc] init];
    adapter->_model = model;
    adapter->_tableView = tableview;
    adapter->_controller = controller;
    
    tableview.delegate = adapter;
    tableview.dataSource = adapter;
    [tableview registerClass:StageSelectCell.class forCellReuseIdentifier:StageSelectCellReuseIdentifier];
    
    return adapter;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model.stages.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StageSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:StageSelectCellReuseIdentifier forIndexPath:indexPath];
    
    Level *level = self.model.stages[indexPath.section];
    cell.name = level.name;
    cell.bestStep = level.bestStep;
    cell.isCollect = level.isFavorite;
    if (indexPath.section % 2) {
        cell.bestStep = 4;
    }
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.controller.router
     pushForRouterPath:@"LevelController"
     parameters:@{
        @"level" : self.model.stages[indexPath.section]
    }];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    Level *level = self.model.stages[indexPath.section];
    NSString *title = (level.isFavorite ? @"取消" : @"收藏");
    
    UIContextualAction *collect =
    [UIContextualAction
     contextualActionWithStyle:UIContextualActionStyleNormal
     title:title
     handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        level.isFavorite = !level.isFavorite;
        StageSelectCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.isCollect = level.isFavorite;
        completionHandler(YES);
    }];
    collect.backgroundColor =
    [UIColor Any_hex:@"#A13502" a:0.1 Dark_hex:@"#351300" a:0.1];
    
    collect.image =
    [[[UIGraphicsImageRenderer alloc]
     initWithSize:CGSizeMake(50, 50)]
     imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        UIImage *img = [UIImage imageNamed:
                        (level.isFavorite ? @"uncollect" : @"collect")];
        [img drawInRect:CGRectMake(0, 0, 50, 50)];
    }];
    
    return [UISwipeActionsConfiguration configurationWithActions:@[collect]];
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > 0) {
        return;
    }
    
    StageTopView *topView = (StageTopView *)self.tableView.tableHeaderView;
    topView.contentView.top = scrollView.contentOffset.y;
    [topView.contentView stretchBottom_toPointY:topView.SuperBottom offset:0];
    [topView drawRect:CGRectMake(0, 0, topView.contentView.width, topView.contentView.height)];
    
    static BOOL down = YES;
    static CGFloat currentY = 0;
    if (scrollView.contentOffset.y < currentY) {
        if (scrollView.contentOffset.y <= -100 && down) {
            UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
            [generator impactOccurred];
            
            down = NO;
        }
    } else {
        if (scrollView.contentOffset.y > -100 && !down) {
            down = YES;
        }
    }
    currentY = scrollView.contentOffset.y;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView.contentOffset.y <= -100 && velocity.y < 0) {
        *targetContentOffset = CGPointMake(0, -300);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [scrollView setContentOffset:CGPointMake(0, -scrollView.height + 350) animated:YES];
        });
    }
}

@end
