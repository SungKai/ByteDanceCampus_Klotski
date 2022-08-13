//
//  TeamIntroduceModel.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/13.
//

#import "TeamIntroduceModel.h"

@implementation TeamIntroduceModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.content = dictionary[@"content"];
        self.github = dictionary[@"github"];
    }
    return self;
}

+ (NSMutableArray<TeamIntroduceModel *> *)ourTeamAry {
    NSArray *array = [NSArray arrayWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"team" ofType:@"plist"]];
    NSMutableArray <TeamIntroduceModel *> *modelAry = NSMutableArray.array;
    for (NSDictionary *dic in array) {
        TeamIntroduceModel *model = [[TeamIntroduceModel alloc] initWithDictionary:dic];
        [modelAry addObject:model];
    }
    return modelAry;
}

@end
