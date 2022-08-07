//
//  Level.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

#import "Level.h"

#import <WCDB.h>

#import <array>
#import <iostream>

NSString *LevelTableName = @"Level";

#pragma mark - Level ()

@interface Level ()

/// 唯一ID
@property (nonatomic) std::array<std::array<long, 4>, 5> onlyCode;

/// 数据库
@property(nonatomic, readonly, class) WCTDatabase *DB;

@end

#pragma mark - Level (WCTTableCoding)

@interface Level (WCTTableCoding) <
    WCTTableCoding
>

WCDB_PROPERTY(idCode)
WCDB_PROPERTY(name)
WCDB_PROPERTY(bestStep)
WCDB_PROPERTY(currentStep)
WCDB_PROPERTY(persons)
WCDB_PROPERTY(currentPersons)

@end

#pragma mark - Level

@implementation Level

#pragma mark - (WCTTableCoding)

WCDB_IMPLEMENTATION(Level)
WCDB_SYNTHESIZE(Level, idCode)
WCDB_SYNTHESIZE(Level, name)
WCDB_SYNTHESIZE(Level, bestStep)
WCDB_SYNTHESIZE(Level, currentStep)
WCDB_SYNTHESIZE(Level, persons)
WCDB_SYNTHESIZE(Level, currentPersons)

WCDB_PRIMARY(Level, idCode)

#pragma mark - Life cycle

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
        _bestStep = -1;
        _currentStep = 0;
        NSMutableArray *mutAry = NSMutableArray.array;
        NSMutableArray *mutCAry = NSMutableArray.array;
        for (NSDictionary *dic in dictionary[@"blocks"]) {
            Person *person = [[Person alloc] initWithDictionary:dic];
            [mutAry addObject:person];
            [mutCAry addObject:person.copy];
        }
        _persons = mutAry.copy;
        _currentPersons = mutCAry.copy;
    }
    return self;
}

#pragma mark - Getter

+ (NSString *)DBpath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"level_database"];;
}

- (NSString *)idCode {
    NSMutableString *str = [NSMutableString stringWithCapacity:4 * 5];
    for(std::array<long, 4> ary : self.onlyCode) {
        for (long type : ary) {
            [str appendFormat:@"%ld", type];
        }
    }
    return str;
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
    if (_persons == persons) {
        // 重来
        for (NSInteger i = 0; i < _persons.count; i++) {
            self.currentPersons[i].frame = _persons[i].frame;
        }
        self.currentStep = 0;
        return;
    }
    // 新的布局
    _persons = persons.copy;
    
    NSMutableArray <Person *> *newPerons = NSMutableArray.array;
    for (Person *p in _persons) {
        Person *newP = p.copy;
        [newPerons addObject:newP];
    }
    _currentPersons = newPerons.copy;
    
    std::array<std::array<long, 4>, 5> array = {};
    for (Person *person in _persons) {
        for (int i = person.x; i < (person.x + person.width); i++) {
            for (int j = person.y; j < (person.y + person.height); j++) {
                array[j][i] = person.type;
            }
        }
    }
    self.onlyCode = array;
    self.bestStep = 0;
    self.currentStep = 0;
}

@end

#pragma mark - Level (Step)

@implementation Level (Step)

- (BOOL)currentPersonAtIndex:(NSInteger)index
          canMoveToDirection:(PersonDirection)direction {
    // TODO: 是否可以移动的算法 >>>
    // 对onlyCode的判断
    Person *person = self.currentPersons[index];
    switch (direction) {
        case PersonDirectionRight: {
            
        } break;
            
        case PersonDirectionLeft: {
            
        } break;
            
        case PersonDirectionUP: {
            
        } break;
            
        case PersonDirectionDown: {
            
        } break;
    }
    // FIXME: <<<
    
    return YES;
}

- (void)currentPersonAtIndex:(NSInteger)index
                      moveTo:(PersonDirection)direction {
    // TODO: move的算法,这里简单写了下视图call过来的，差算法 >>>
    // 对onlyCode的改变
    // FIXME: <<<
    Person *person = self.currentPersons[index];
    switch (direction) {
        case PersonDirectionUP: {
            person.y -= 1;
        } break;
            
        case PersonDirectionLeft: {
            person.x -= 1;
        } break;
            
        case PersonDirectionDown: {
            person.y += 1;
        } break;
            
        case PersonDirectionRight: {
            person.x += 1;
        } break;
    }
}

- (void)currentPersonAtIndex:(NSInteger)index didMoveWithProposedDirection:(PersonDirection)direction {
    // TODO: 当视图移动完后会掉用此方法 >>>
    // 对onlyCode的改变
    // FIXME: <<<
}

- (void)reset {
    self.persons = self.persons;
}

- (BOOL)isGameOver {
    return (self.onlyCode[4][1] == PersonBigSquare &&
            self.onlyCode[4][2] == PersonBigSquare);
}

- (NSArray<PersonStep *> *)stepForCurrent {
    NSMutableArray <PersonStep *> *mutAry = NSMutableArray.array;
    // TODO: 算法
    // 不允许改变person以及
    return mutAry;
}

@end
