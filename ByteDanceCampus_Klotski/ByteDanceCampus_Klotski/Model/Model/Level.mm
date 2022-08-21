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

#import <iostream>

NSString *LevelTableName = @"Level";

#pragma mark - TreeNode

/**
 *  广度优先树节点结构
 *  仅用于算法
 */

typedef struct TreeNode {
    std::array<int, 20> code;  // 棋盘布局
//    std::array<PersonStruct, 10> array;   //此时棋子的状态
    std::vector<PersonStruct> array;
//    int floor;    // 树的深度
//    int num;     // 树的宽度
    int index;   // 上一步使用的棋子
    int moveTo;  // 上一步移动方向
    struct TreeNode* before;    // 父节点
//    TreeNode(TreeNode* before) : before(before){};
} TreeNode;

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

WCDB_PRIMARY(Level, originLayoutStr)

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

- (void)_setCodeWithPerson:(Person *)person {
    for (int i = person.x; i < (person.x + person.width); i++) {
        for (int j = person.y; j < (person.y + person.height); j++) {
            _onlyCode[j * 4 + i] = (int)person.type;
        }
    }
}

- (void)_saveCurrentLayout {
    _currentLayoutStr = NSMutableString.string;
    for (int p = 0; p < _personAry.count; p++) {
        Person *person = _personAry[p];
        
        [_currentLayoutStr appendFormat:@"%d%d ", person.x, person.y];
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
        if (aStr.length < 4) {
            continue;
        }
        int x = [aStr substringWithRange:NSMakeRange(0, 1)].intValue;
        int y = [aStr substringWithRange:NSMakeRange(1, 1)].intValue;
        int width = [aStr substringWithRange:NSMakeRange(2, 1)].intValue;
        int height = [aStr substringWithRange:NSMakeRange(3, 1)].intValue;
        NSString *name = [aStr substringFromIndex:4];
        
        Person *p = [[Person alloc] init];
        p.name = name;
        p.frame = PersonFrameMake(x, y, width, height);
        p.index = i;
        [mutAry addObject:p];
        
        [self _setCodeWithPerson:p];
    }
    _personAry = mutAry.copy;
}

- (void)setCurrentLayoutStr:(NSMutableString *)currentLayoutStr {
    _currentLayoutStr = currentLayoutStr;
    if (!_currentLayoutStr && _currentLayoutStr.length < 2) {
        return;
    }

    NSArray <NSString *> *strAry = [_currentLayoutStr componentsSeparatedByString:@" "];

    for (int i = 0; i < strAry.count; i++) {
        NSString *aStr = strAry[i];
        if (aStr.length < 4) {
            continue;
        }
        int x = [aStr substringWithRange:NSMakeRange(0, 1)].intValue;
        int y = [aStr substringWithRange:NSMakeRange(1, 1)].intValue;

        Person *p = _personAry[i];
        p.x = x;
        p.y = y;
    }
    
    [self resetLayout];
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
    
    std::array<int, 20> t = {};
    _onlyCode = t;
    _originLayoutStr = NSMutableString.string;
    for (int p = 0; p < _personAry.count; p++) {
        Person *person = _personAry[p];
        person.index = p;
        
        [_originLayoutStr appendFormat:@"%@ ", person.code];
        
        [self _setCodeWithPerson:person];
    }
    
    [self _saveCurrentLayout];
    
    [Level.DB
     insertOrReplaceObject:self
     onProperties:
     {Level.name, Level.currentStep, Level.bestStep, Level.isFavorite, Level.originLayoutStr, Level.currentLayoutStr}
     into:LevelTableName];
}

- (void)resetLayout {
    NSArray <NSString *> *strAry = [_originLayoutStr componentsSeparatedByString:@" "];
    for (int i = 0; i < strAry.count; i++) {
        NSString *aStr = strAry[i];
        if (aStr.length < 2) {
            continue;
        }
        int x = [aStr substringWithRange:NSMakeRange(0, 1)].intValue;
        int y = [aStr substringWithRange:NSMakeRange(1, 1)].intValue;
        
        Person *p = _personAry[i];
        p.x = x;
        p.y = y;
    }
    
    std::array<int, 20> t = {};
    _onlyCode = t;
    for (Person *p in _personAry) {
        [self _setCodeWithPerson:p];
    }
}

- (void)updateDB {
    [self _saveCurrentLayout];
    
    [Level.DB
     updateAllRowsInTable:LevelTableName
     onProperties:
     {Level.name, Level.currentStep, Level.bestStep, Level.isFavorite, Level.currentLayoutStr}
     withObject:self];
}

@end













#pragma mark - Level (Step)

@implementation Level (Step)

// MARK: can move

- (BOOL)personStruct:(PersonStruct)person
  canMoveToDirection:(PersonDirection)direction
          checkBoard:(std::array<int, 20>)board {
    switch (direction) {
        case PersonDirectionRight: {
            if(person.type == 0)
                return false;
            if(person.frame.x + person.frame.width == 4)
                return false;
            for (int i = person.frame.y; i < person.frame.y + person.frame.height; i++) {
                if (board[i * 4 + person.frame.x + person.frame.width]) {
                    return false;
                }
            }
            return true;
        } break;
            
        case PersonDirectionLeft: {
            if(person.type == 0)
                return false;
            if(person.frame.x == 0)
                return false;
            for (int i = person.frame.y; i < person.frame.y + person.frame.height; i++) {
                if (board[i * 4 + person.frame.x - 1]) {
                    return false;
                }
            }
            return true;
        } break;
            
        case PersonDirectionUP: {
            if(person.type == 0)
                return false;
            if(person.frame.y == 0)
                return false;
            for (int i = person.frame.x ; i < person.frame.x + person.frame.width; i++) {
                if (board[(person.frame.y - 1) * 4 + i]) {
                    return false;
                }
            }
            return true;
        } break;
            
        case PersonDirectionDown: {
            if(person.type == 0)
                return false;
            if(person.frame.y + person.frame.height == 5)
                return false;
            for (int i = person.frame.x ; i < person.frame.x + person.frame.width; i++) {
                if (board[(person.frame.y + person.frame.height) * 4 + i]) {
                    return false;
                }
            }
            return true;
        } break;
    }
    return NO;
}

- (BOOL)currentPersonAtIndex:(NSInteger)index
          canMoveToDirection:(PersonDirection)direction {
    Person *person = self.personAry[index];
    return [self personStruct:person.perStruct canMoveToDirection:direction checkBoard:_onlyCode];
}

// MARK: move to

- (void)personStruct:(PersonStruct &)person
              moveTo:(PersonDirection)direction
          checkBoard:(std::array<int, 20> &)board {
    switch (direction) {
        case PersonDirectionUP: {
            for (int i = person.frame.x; i < person.frame.x + person.frame.width; i++) {
                board[(person.frame.y + person.frame.height - 1) * 4 + i] = 0;
                board[(person.frame.y - 1) * 4 + i] = (int)person.type;
            }
            person.frame.y -= 1;
        } break;
            
        case PersonDirectionLeft: {
            for (int i = person.frame.y; i < person.frame.y + person.frame.height; i++) {
                board[i * 4 + person.frame.x - 1] = (int) person.type;
                board[i * 4 + person.frame.x + person.frame.width - 1] = 0;
            }
            person.frame.x -= 1;
        } break;
            
        case PersonDirectionDown: {
            for (int i = person.frame.x; i < person.frame.x + person.frame.width; i++) {
                board[person.frame.y * 4 + i] = 0;
                board[(person.frame.y + person.frame.height) * 4 + i] = (int)person.type;
            }
            person.frame.y += 1;
        } break;
            
        case PersonDirectionRight: {
            for (int i = person.frame.y; i < person.frame.y + person.frame.height; i++) {
                board[i * 4 + person.frame.x + person.frame.width] = (int)person.type;
                board[i * 4 + person.frame.x] = 0;
            }
            person.frame.x += 1;
        } break;
    }
}

- (void)currentPersonAtIndex:(NSInteger)index
                      moveTo:(PersonDirection)direction {
    Person *person = self.personAry[index];
    PersonStruct perStruct = person.perStruct;

    [self personStruct:perStruct moveTo:direction checkBoard:_onlyCode];
    person.perStruct = perStruct;
    return;
}

// MARK: game over

- (BOOL)isGameOverWithCheckBoard:(std::array<int, 20>)board {
    return (board[18] == 4 && board[19] == 4);
}

- (BOOL)isGameOver {
    return [self isGameOverWithCheckBoard:_onlyCode];
}

// MARK: solve problem












- (NSArray<NSDictionary<NSNumber *,NSNumber *> *> *)stepForCurrent {

    std::vector<std::vector<TreeNode>> A;
    
    std::vector<PersonStruct> per;
    for (Person *p in _personAry) {
        per.insert(per.end(), p.perStruct);
    }
    
    //以此刻棋盘为树顶点
    TreeNode father = {_onlyCode, per, 0, 0, NULL};
    std::vector<TreeNode> fatherV = {father};
    A.push_back(fatherV);
    
    //是否获胜
    Boolean victory = false;
    
    //记录深度
    int a = 0;
    
    //获胜节点
    TreeNode Atree;
    
    //树的深度在找到华容道答案前是未知的，所以使用while遍历。
    //使用A[]访问树的深度；使用A[].size或a[][]访问树的广度，即每一层的节点数。
    while(!victory) {
        
        //加载每个棋子的布局，全部统一使用上、下、左、右，这个顺序，防止太乱。
        //开始遍历某一层的全部节点
        for(int k = 0; k < A[a].size(); k++) {
            //创建此层的临时容器
            std::vector<TreeNode> all;
            
            //记录广度
            int b = 0;
            
            for(int i = 0; i < _personAry.count; i++) {
                
                if([self personStruct:A[a][k].array[i] canMoveToDirection:PersonDirectionUP checkBoard:A[a][k].code]){
                    //备份当前的数据，用于还原
                    PersonStruct per = A[a][k].array[i];
                    std::array<int, 20> num = A[a][k].code;
                    
                    [self personStruct:A[a][k].array[i] moveTo:PersonDirectionUP checkBoard:A[a][k].code];
                    std::vector<PersonStruct> arr = A[a][k].array;
                    
                    
                    //添加节点
                    TreeNode node = { A[a][k].code, arr, i, PersonDirectionUP, &A[a][k]};
                    all.push_back(node);
                    
                    //注意！！！一定要把棋盘还原为父节点！！！不然子节点会直接覆盖父节点
                    A[a][k].array[i] = per;
                    A[a][k].code = num;
                    
                    //更新广度
                    b++;
                }
                
                if([self personStruct:A[a][k].array[i] canMoveToDirection:PersonDirectionDown checkBoard:A[a][k].code]){
                    //备份当前的数据，用于还原
                    PersonStruct per = A[a][k].array[i];
                    std::array<int, 20> num = A[a][k].code;
                    
                    [self personStruct:A[a][k].array[i] moveTo:PersonDirectionDown checkBoard:A[a][k].code];
                    //记录下一节点的常规数据
                    std::vector<PersonStruct> arr = A[a][k].array;
                    
                    //添加节点
                    TreeNode node = {A[a][k].code, arr, i, PersonDirectionDown, &A[a][k]};
                    all.push_back(node);
                    
                    //注意！！！一定要把棋盘还原为父节点！！！不然子节点会直接覆盖父节点
                    A[a][k].array[i] = per;
                    A[a][k].code = num;
                    
                    //更新广度
                    b++;
                }
                
                
                if([self personStruct:A[a][k].array[i] canMoveToDirection:PersonDirectionLeft checkBoard:A[a][k].code]){
                    //备份当前的数据，用于还原
                    PersonStruct per = A[a][k].array[i];
                    std::array<int, 20> num = A[a][k].code;
                    
                    [self personStruct:A[a][k].array[i] moveTo:PersonDirectionLeft checkBoard:A[a][k].code];
                    //记录下一节点的常规数据

                    std::vector<PersonStruct> arr = A[a][k].array;
                    
                    //添加节点
                    TreeNode node = {A[a][k].code, arr, i, PersonDirectionLeft, &A[a][k]};
                    all.push_back(node);
                    
                    //注意！！！一定要把棋盘还原为父节点！！！不然子节点会直接覆盖父节点
                    A[a][k].array[i] = per;
                    A[a][k].code = num;
                    
                    //更新广度
                    b++;
                }
                
                
                if([self personStruct:A[a][k].array[i] canMoveToDirection:PersonDirectionRight checkBoard:A[a][k].code]){
                    //备份当前的数据，用于还原
                    PersonStruct per = A[a][k].array[i];
                    std::array<int, 20> num = A[a][k].code;
                    
                    [self personStruct:A[a][k].array[i] moveTo:PersonDirectionRight checkBoard:A[a][k].code];
                    //记录下一节点的常规数据

//                    std::array<PersonStruct, 10> arr = A[a][k].array;
                    std::vector<PersonStruct> arr = A[a][k].array;
                    
                    //添加节点
                    TreeNode node = {A[a][k].code, arr, i, PersonDirectionRight, &A[a][k]};
                    all.push_back(node);
                    
                    //注意！！！一定要把棋盘还原为父节点！！！不然子节点会直接覆盖父节点
                    A[a][k].array[i] = per;
                    A[a][k].code = num;
                    
                    //更新广度
                    b++;
                }
            }//遍历此节点的全部棋子结束
            
            
            //遍历此层，检查是否有重复的棋盘，有的话直接把这个节点杀死
            //说明：先不写，如果后面有时间，再来写
//                for()
            

            A.push_back(all);//将临时容器装入树的整一层
            //把判断是否获胜单独拿出来放在这里
//            RisingDetailLog(@"😀A : %lu", A.size());
            for(int s = 0; s< A[a+1].size(); s++){
//                if (A[a+1][s].index < 0) {
//                    NSAssert(NO, @"");
//                }
//                if (A[a+1][s].moveTo > 3) {
//                    NSAssert(NO, @"");
//                }
                std::cout << A[a+1][s].index << "   " << A[a+1][s].moveTo << std::endl;
                if([self isGameOverWithCheckBoard:A[a+1][s].code]){
                    victory = true;
                    Atree = A[a+1][s];
                }
            }
            
            
            a++;//更新深度，即进入树的下一层
        }//遍历此层的全部节点结束
        
        
        
        
        
    }//遍历整棵树的全部层结束
    
    
    
    
    
    
    
    
    //将整个树的答案树枝装入t中,i遍历到1就行，因为树的顶级节点不需要操作
    NSMutableArray <NSDictionary <NSNumber *,NSNumber *> *> *mutAry = NSMutableArray.array;
    for(int i = a; i >= 1; i--){
        
//        std::map<int, int> map;
//        map.insert(std::make_pair(Atree.index, Atree.moveTo));
//        t.insert(t.begin(), map);
//        Atree = *Atree.before;
        
        NSDictionary <NSNumber *,NSNumber *> *aDic = @{@(Atree.index):@(Atree.moveTo)};
        [mutAry insertObject:aDic atIndex:0];
        Atree = *Atree.before;
    }
    return mutAry.copy;
    
}

@end
