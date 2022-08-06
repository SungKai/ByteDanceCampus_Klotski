//
//  PersonStep.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/5.
//

#import "PersonStep.h"

#pragma mark - PersonStep

@implementation PersonStep

+ (instancetype)stepForPerson:(Person *)person direction:(PersonDirection)direction {
    PersonStep *step = [[PersonStep alloc] init];
    step.person = person;
    step.direction = direction;
    return step;
}

@end
