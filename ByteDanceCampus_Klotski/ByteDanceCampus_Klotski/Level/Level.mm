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

/// 数据库
@property(nonatomic, readonly, class) WCTDatabase *DB;

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
WCDB_SYNTHESIZE(Level, onlyCode)
WCDB_SYNTHESIZE(Level, name)
WCDB_SYNTHESIZE(Level, bestStep)
WCDB_SYNTHESIZE(Level, currentStep)
WCDB_SYNTHESIZE(Level, persons)
WCDB_SYNTHESIZE(Level, currentPersons)

WCDB_PRIMARY(Level, onlyCode)

#pragma mark - Life cycle

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
        _bestStep = -1;
        _currentStep = 0;
        NSMutableArray *mutAry = NSMutableArray.array;
        for (NSDictionary *dic in dictionary[@"blocks"]) {
            [mutAry addObject:[[Person alloc] initWithDictionary:dic]];
        }
        self.persons = mutAry.copy;
        _currentPersons = mutAry.copy;
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

+ (WCTDatabase *)DB {
    static WCTDatabase *_db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _db = [[WCTDatabase alloc] initWithPath:self.DBpath];
        [_db createTableAndIndexesOfName:LevelTableName withClass:self];
    });
    return _db;
}

#pragma mark - Setter

- (void)setPersons:(NSArray<Person *> *)persons {
    _persons = persons.copy;
    // TODO: 考虑唯一id的算法
}

@end
