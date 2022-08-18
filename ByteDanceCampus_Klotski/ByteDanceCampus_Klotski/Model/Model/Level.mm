//
//  Level.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

#import "Level.h"

#import <WCDB.h>

#import <array>
#import <map>
#import <vector>

NSString *LevelTableName = @"Level";

#pragma mark - Level ()

@interface Level ()

/// 初始布局
/// 每组为当前person的code
/// @"1022曹操 0012张飞 "
@property (nonatomic, strong) NSMutableString *originLayoutStr;

/// 当前布局
/// 每组为当前person的x, y
/// @"10 00"
@property (nonatomic, strong) NSMutableString *currentLayoutStr;

/// 棋盘布局
/// [2,4,4,2,2,4,4,2,2,3,3,2,2,1,1,2,1,0,0,1]
@property (nonatomic) std::array<int, 20> onlyCode;

/// 数据库
@property(nonatomic, readonly, class) WCTDatabase *DB;

@end

#pragma mark - Level (WCTTableCoding)

@interface Level (WCTTableCoding) <
    WCTTableCoding
>

WCDB_PROPERTY(name)
WCDB_PROPERTY(currentStep)
WCDB_PROPERTY(bestStep)
WCDB_PROPERTY(isFavorite)
WCDB_PROPERTY(originLayoutStr)
WCDB_PROPERTY(currentLayoutStr)

@end

#pragma mark - Level

@implementation Level

#pragma mark - (WCTTableCoding)

WCDB_IMPLEMENTATION(Level)

WCDB_SYNTHESIZE(Level, name)
WCDB_SYNTHESIZE(Level, currentStep)
WCDB_SYNTHESIZE(Level, bestStep)
WCDB_SYNTHESIZE(Level, isFavorite)
WCDB_SYNTHESIZE(Level, originLayoutStr)
WCDB_SYNTHESIZE(Level, currentLayoutStr)

#pragma mark - Life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        _bestStep = -1;
        _originLayoutStr = NSMutableString.string;
        std::array<int, 20> t = {};
        _onlyCode = t;
    }
    return self;
}

#pragma mark - Privety Method

- (void)__setCodeWithPerson:(Person *)person {
    for (int i = person.x; i < (person.x + person.width); i++) {
        for (int j = person.y; j < (person.y + person.height); j++) {
            _onlyCode[j * 4 + i] = (int)person.type;
        }
    }
}

#pragma mark - Getter

+ (NSString *)DBpath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"Klotski_database"];
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

- (void)setOriginLayoutStr:(NSMutableString *)originLayoutStr {
    _originLayoutStr = originLayoutStr;
    
    NSArray <NSString *> *strAry = [_originLayoutStr componentsSeparatedByString:@" "];
    NSMutableArray <Person *> *mutAry = [NSMutableArray arrayWithCapacity:strAry.count];
    std::array<int, 20> t = {};
    _onlyCode = t;
    
    for (int i = 0; i < strAry.count; i++) {
        NSString *aStr = strAry[i];
        int x = [aStr substringWithRange:NSMakeRange(0, 1)].intValue;
        int y = [aStr substringWithRange:NSMakeRange(1, 1)].intValue;
        int width = [aStr substringWithRange:NSMakeRange(2, 1)].intValue;
        int height = [aStr substringWithRange:NSMakeRange(3, 1)].intValue;
        NSString *name = [aStr substringFromIndex:4];
        
        Person *p = [[Person alloc] init];
        p.name = name;
        p.frame = PersonFrameMake(x, y, width, height);
        [mutAry addObject:p];
        
        [self __setCodeWithPerson:p];
    }
    _personAry = mutAry.copy;
}

- (void)setCurrentLayoutStr:(NSMutableString *)currentLayoutStr {
    _currentLayoutStr = currentLayoutStr;
    
    NSArray <NSString *> *strAry = [_originLayoutStr componentsSeparatedByString:@" "];
    std::array<int, 20> t = {};
    _onlyCode = t;
    
    for (int i = 0; i < strAry.count; i++) {
        NSString *aStr = strAry[i];
        int x = [aStr substringWithRange:NSMakeRange(0, 1)].intValue;
        int y = [aStr substringWithRange:NSMakeRange(1, 1)].intValue;
        
        Person *p = _personAry[i];
        p.x = x;
        p.y = y;
        
        [self __setCodeWithPerson:p];
    }
}

@end





#pragma mark - Level (CRUD)

@implementation Level (CRUD)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];

    NSMutableArray *mutAry = NSMutableArray.array;
    for (NSDictionary *dic in dictionary[@"blocks"]) {
        Person *person = [[Person alloc] initWithDictionary:dic];
        [mutAry addObject:person];
    }
    
    return [self initWithName:name persons:mutAry.copy];
}

- (instancetype)initWithName:(NSString *)name persons:(NSArray<Person *> *)personAry {
    self = [self init];
    if (self) {
        _name = name.copy;
        [self replacePersons:personAry.copy];
    }
    return self;
}

+ (NSArray<Level *> *)WCDBAry {
    return [self.DB getAllObjectsOfClass:self.class fromTable:LevelTableName];
}

- (void)replacePersons:(NSArray<Person *> *)personAry {
    _personAry = personAry.copy;
    
    for (int p = 0; p < _personAry.count; p++) {
        Person *person = _personAry[p];
        
        [_originLayoutStr appendFormat:@"%@ ", person.code];
        
        [self __setCodeWithPerson:person];
    }
    
    // FIXME: insertOrReplaceObject
    // [Level.DB insertOrReplaceObject:self onProperties:{Level.name} into:LevelTableName];
}

- (void)resetLayout {
    NSArray <NSString *> *strAry = [_originLayoutStr componentsSeparatedByString:@" "];
    for (int i = 0; i < strAry.count; i++) {
        NSString *aStr = strAry[i];
        int x = [aStr substringWithRange:NSMakeRange(0, 1)].intValue;
        int y = [aStr substringWithRange:NSMakeRange(1, 1)].intValue;
        
        Person *p = _personAry[i];
        p.x = x;
        p.y = y;
        [self __setCodeWithPerson:p];
    }
}

- (void)updateDB {
    // TODO: updateAllRowsInTable
//    [Level.DB
//     updateAllRowsInTable:LevelTableName
//     onProperties:
//     {Level.name, Level.bestStep, Level.currentStep, Level.isFavorite}
//     withObject:self];
}

@end






#pragma mark - Level (Step)

@implementation Level (Step)

- (BOOL)currentPersonAtIndex:(NSInteger)index
          canMoveToDirection:(PersonDirection)direction {
    Person *person = self.personAry[index];
    switch (direction) {
        case PersonDirectionRight: {
            if(person.type == 0)
                return false;
            if(person.x + person.width == 4)
                return false;
            for (int i = person.y; i < person.y + person.height; i++) {
                if (_onlyCode[i * 4 + person.x + person.width]) {
                    return false;
                }
            }
            return true;
        } break;
            
        case PersonDirectionLeft: {
            if(person.type == 0)
                return false;
            if(person.x == 0)
                return false;
            for (int i = person.y; i < person.y + person.height; i++) {
                if (_onlyCode[i * 4 + person.x - 1]) {
                    return false;
                }
            }
            return true;
        } break;
            
        case PersonDirectionUP: {
            if(person.type == 0)
                return false;
            if(person.y == 0)
                return false;
            for (int i = person.x ; i < person.x + person.width; i++) {
                if (_onlyCode[(person.y - 1) * 4 + i]) {
                    return false;
                }
            }
            return true;
        } break;
            
        case PersonDirectionDown: {
            if(person.type == 0)
                return false;
            if(person.y + person.height == 5)
                return false;
            for (int i = person.x ; i < person.x + person.width; i++) {
                if (_onlyCode[(person.y + person.height) * 4 + i]) {
                    return false;
                }
            }
            return true;
        } break;
    }
    // FIXME: <<<
    
    return YES;
}

- (void)currentPersonAtIndex:(NSInteger)index
                      moveTo:(PersonDirection)direction {
    Person *person = self.personAry[index];
    switch (direction) {
        case PersonDirectionUP: {
            for (int i = person.x; i < person.x + person.width; i++) {
                _onlyCode[(person.y + person.height - 1) * 4 + i] = 0;
                _onlyCode[(person.y - 1) * 4 + i] = (int)person.type;
            }
            person.y -= 1;
        } break;
            
        case PersonDirectionLeft: {
            for (int i = person.y; i < person.y + person.height; i++) {
                _onlyCode[i * 4 + person.x - 1] = (int) person.type;
                _onlyCode[i * 4 + person.x + person.width - 1] = 0;
            }
            person.x -= 1;
        } break;
            
        case PersonDirectionDown: {
            for (int i = person.x; i < person.x + person.width; i++) {
                _onlyCode[person.y * 4 + i] = 0;
                _onlyCode[(person.y + person.height) * 4 + i] = (int)person.type;
            }
            person.y += 1;
        } break;
            
        case PersonDirectionRight: {
            for (int i = person.y; i < person.y + person.height; i++) {
                _onlyCode[i * 4 + person.x + person.width] = (int)person.type;
                _onlyCode[i * 4 + person.x] = 0;
            }
            person.x += 1;
        } break;
    }
}

- (BOOL)isGameOver {
    if(self.onlyCode[18] == 4 && self.onlyCode[19] == 4)
        return YES;
    return NO;
}

- (NSArray<NSDictionary<NSNumber *,NSNumber *> *> *)stepForCurrent {
    
    // TODO: 算法
    // 不允许改变person以及
    std::vector<std::map<int, int>> t;
    
    
    
    
    
    
    
    return nil;
}

@end
