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

/// 头视图
@property (nonatomic, strong) StageTopView *topView;

/// 模型
@property (nonatomic, strong) StageSelectModel *model;

/// VC
@property (nonatomic, weak) UIViewController *controller;

/// 是否是子视图在滑动
@property (nonatomic) BOOL isChildScroll;

@end

#pragma mark - StageSelectAdapter

@implementation StageSelectAdapter

#pragma mark - Life cycle

+ (instancetype)adapterWithController:(UIViewController *)controller
                            tableView:(UITableView *)tableview
                      tableHeaderView:(nonnull StageTopView *)topView
                                model:(nonnull StageSelectModel *)model {
    
    StageSelectAdapter *adapter = [[StageSelectAdapter alloc] init];
    adapter->_model = model;
    adapter->_tableView = tableview;
    adapter->_controller = controller;
    adapter->_topView = topView;
    tableview.tableHeaderView = topView;
    
    tableview.delegate = adapter;
    tableview.dataSource = adapter;
    [tableview registerClass:StageSelectCell.class forCellReuseIdentifier:StageSelectCellReuseIdentifier];
    
    return adapter;
}

#pragma mark - Setter

- (void)setScrollView:(UIScrollView *)scrollView {
    [_scrollView removeFromSuperview];
    
    _scrollView = scrollView;
    
    scrollView.delegate = self;
    scrollView.height = 0;
    scrollView.top = self.topView.topBelowTitle + 100;
    scrollView.centerX = self.tableView.width / 2;
    scrollView.alpha = 0;
    
    [self.tableView addSubview:scrollView];
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
    [UIColor Any_hex:@"#EEDBA2" a:0.1 Dark_hex:@"#4F3119" a:0.1];
    
    collect.image = [[UIImage imageNamed: (level.isFavorite ? @"uncollect" : @"collect")] imageByResizeToSize:CGSizeMake(50, 50)];
    
    return [UISwipeActionsConfiguration configurationWithActions:@[collect]];
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 是tableView
    if (scrollView == self.tableView) {
        self.isChildScroll = NO;
        // 正常滑动就直接返回
        if (scrollView.contentOffset.y >= 0) {
            [self.controller.tabBarController tabBarVisible:YES animated:YES];
            return;
        }
        // 向下滑动则吸顶
        self.topView.contentView.top = scrollView.contentOffset.y;
        [self.topView.contentView stretchBottom_toPointY:self.topView.SuperBottom offset:0];
        // 有子scroll则子scrollView放大
        if (self.scrollView) {
            self.scrollView.top = self.topView.contentView.top + self.topView.topBelowTitle;
            self.scrollView.height = -scrollView.contentOffset.y;
            [self.scrollView drawRect:self.scrollView.frame];
        }
    } else {
        CGFloat height = -self.tableView.height + 350;
        if (self.isChildScroll) {
            // 如果子视图正在滑动，父视图则保持原样
            self.tableView.contentOffset = CGPointMake(0, height);
        }
        
        CGFloat bottom = scrollView.contentSize.height - scrollView.bounds.size.height;
        if (scrollView.contentOffset.y >= bottom) {
            // 如果子视图滑动到底部
            self.tableView.contentOffset = CGPointMake(0, self.tableView.contentOffset.y + scrollView.contentOffset.y - bottom);
            // 保持子视图在底部
            scrollView.contentOffset = CGPointMake(0, bottom);
            self.isChildScroll = NO;
        }
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    // 如果没有scrollView则不用显示悬停，在展示scrollView也直接返回
    if (self.scrollView == nil) {
        return;
    }
    
    if (scrollView == self.tableView) {
        if ((scrollView.contentOffset.y <= -100 && velocity.y < 0)
            || scrollView.contentOffset.y <= -500) {
            
            *targetContentOffset = CGPointMake(0, -scrollView.height + 350);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [scrollView setContentOffset:CGPointMake(0, -scrollView.height + 350) animated:YES];
                [self.controller.tabBarController tabBarVisible:NO animated:YES];
            });
            return;
        }
    }
}

@end
