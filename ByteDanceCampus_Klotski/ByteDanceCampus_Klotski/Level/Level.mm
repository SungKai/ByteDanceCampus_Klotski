//
//  Level.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

#import "Level.h"

#import <WCDB.h>

NSString *LevelTableName = @"Level";

#pragma mark - Level ()

@interface Level ()

/// 唯一ID
@property (nonatomic, copy) NSString *onlyCode;

@end

#pragma mark - Level (WCTTableCoding)

@interface Level (WCTTableCoding) <
    WCTTableCoding
>

WCDB_PROPERTY(name)
WCDB_PROPERTY(bestStep)
WCDB_PROPERTY(currentStep)
WCDB_PROPERTY(onlyCode)
WCDB_PROPERTY(persons)
WCDB_PROPERTY(currentPersons)

@end

#pragma mark - Level

@implementation Level

#pragma mark - (WCTTableCoding)

WCDB_IMPLEMENTATION(Level)
WCDB_PRIMARY(Level, onlyCode)
WCDB_SYNTHESIZE(Level, name)
WCDB_SYNTHESIZE(Level, bestStep)
WCDB_SYNTHESIZE(Level, currentStep)
WCDB_SYNTHESIZE(Level, persons)
WCDB_SYNTHESIZE(Level, currentPersons)

#pragma mark - Life cycle

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.bestStep = -1;
        NSMutableArray *mutAry = NSMutableArray.array;
        for (NSDictionary *dic in dictionary[@"blocks"]) {
            [mutAry addObject:[[Person alloc] initWithDictionary:dic]];
        }
        _persons = mutAry.copy;
    }
    return self;
}

#pragma mark - Getter

+ (NSString *)DBpath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"level_database"];;
}

- (NSString *)idCode {
    return self.onlyCode;
}

@end
