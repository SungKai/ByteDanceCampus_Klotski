//
//  Level.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

#import "Level.h"

#pragma mark - Level ()

@interface Level ()

@end

@implementation Level

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.step = -1;
        NSMutableArray *mutAry = NSMutableArray.array;
        for (NSDictionary *dic in dictionary[@"blocks"]) {
            [mutAry addObject:[[Person alloc] initWithDictionary:dic]];
        }
        _persons = mutAry.copy;
    }
    return self;
}

@end
