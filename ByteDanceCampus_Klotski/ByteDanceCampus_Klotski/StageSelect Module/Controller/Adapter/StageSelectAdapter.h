//
//  StageSelectAdapter.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class StageSelectModel;

#pragma mark - StageSelectAdapter

@interface StageSelectAdapter : NSObject <
    UITableViewDelegate,
    UITableViewDataSource
>

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)adapterWithController:(UIViewController *)controller
                            tableView:(UITableView *)tableview
                                model:(StageSelectModel *)model;

@end

NS_ASSUME_NONNULL_END
