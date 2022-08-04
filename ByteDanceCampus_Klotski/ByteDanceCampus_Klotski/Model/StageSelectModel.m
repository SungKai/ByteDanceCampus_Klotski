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
        NSMutableArray <Level *> *mutAry = NSMutableArray.array;
        NSArray *array = [NSArray arrayWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"level" ofType:@"plist"]];
        for (NSDictionary *dic in array) {
            [mutAry addObject:[[Level alloc] initWithDictionary:dic]];
        }
        _stage = mutAry.copy;
    }
    return self;
}

@end
