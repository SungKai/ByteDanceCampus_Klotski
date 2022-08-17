//
//  StageSelectModel.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

#import "StageSelectModel.h"

@implementation StageSelectModel

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray <Level *> *DBLevels = Level.WCDBAry;
        if (!DBLevels || DBLevels.count == 0) {
            NSMutableArray <Level *> *mutAry = NSMutableArray.array;
            NSArray *array = [NSArray arrayWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"level" ofType:@"plist"]];
            for (NSDictionary *dic in array) {
                Level *model = [[Level alloc] initWithDictionary:dic];
                [mutAry addObject:model];
            }
            _stages = mutAry.copy;
        } else {
            _stages = DBLevels.copy;
        }
    }
    return self;
}

@end
