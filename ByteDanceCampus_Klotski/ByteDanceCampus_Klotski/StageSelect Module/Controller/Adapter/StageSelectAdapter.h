//
//  StageSelectAdapter.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/7.
//

/**StageSelectAdapter
 * 用于解决所有问题的类，
 * 不用设置tableview的代理
 * 也不用设置topView
 * 如果加需求，可以直接改创建方法
 * 或者新增计算属性，并在Controller添加视图
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class StageSelectModel, StageTopView;

#pragma mark - StageSelectAdapter

@interface StageSelectAdapter : NSObject <
    UITableViewDelegate,
    UITableViewDataSource
>

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

/// 创建一个Adapter
/// @param controller 控制器（用于push）
/// @param tableview 视图
/// @param topView 头视图
/// @param model 模型
+ (instancetype)adapterWithController:(UIViewController *)controller
                            tableView:(UITableView *)tableview
                      tableHeaderView:(StageTopView *)topView
                                model:(StageSelectModel *)model;

@end

NS_ASSUME_NONNULL_END
