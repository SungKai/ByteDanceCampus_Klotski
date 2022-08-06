//
//  Level+Step.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/5.
//

#import "Level+Step.h"

#pragma mark - Level (Step)

@implementation Level (Step)

- (BOOL)currentPersonAtIndex:(NSInteger)index
          canMoveToDirection:(PersonDirection)direction {
    // TODO: 是否可以移动的算法
    
    return YES;
}

- (void)currentPersonAtIndex:(NSInteger)index
                      moveTo:(PersonDirection)direction {
    // TODO: move的算法,这里简单写了下视图call过来的，差算法
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
    // TODO: move完回掉，可以开启下一次循环
}

- (void)reset {
    // TODO: 重置
    // ???: 是否得写在主impl
}

- (BOOL)isGameOver {
    // TODO: 判断曹操是否在结束位置
    return NO;
}

- (NSArray<PersonStep *> *)stepForCurrent {
    NSMutableArray <PersonStep *> *mutAry = NSMutableArray.array;
    // TODO: 算法
    return mutAry;
}

@end
