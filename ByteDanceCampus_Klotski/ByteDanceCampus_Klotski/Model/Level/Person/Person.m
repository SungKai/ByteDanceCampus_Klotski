//
//  Person.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.name = dic[@"name"];
        self.x = [dic[@"x"] intValue];
        self.y = [dic[@"y"] intValue];
        self.width = [dic[@"width"] intValue];
        self.height = [dic[@"height"] intValue];
    }
    return self;
}

@end
