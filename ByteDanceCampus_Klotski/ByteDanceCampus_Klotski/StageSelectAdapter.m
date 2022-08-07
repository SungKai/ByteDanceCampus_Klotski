//
//  StageSelectAdapter.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/7.
//

#import "StageSelectAdapter.h"

#import "StageSelectModel.h"

#import "StageSelectCell.h"

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
    return 170;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 60;
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
    collect.backgroundColor = UIColor.greenColor;
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

@end
