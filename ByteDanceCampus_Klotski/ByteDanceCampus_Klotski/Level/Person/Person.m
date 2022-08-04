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
        self.x = [dic[@"y"] intValue];
        self.y = [dic[@"x"] intValue];
        self.width = [dic[@"height"] intValue];
        self.height = [dic[@"width"] intValue];
    }
    return self;
}

#pragma mark - Getter

- (PersonFrame)frame {
    return PersonFrameMake(self.x, self.y, self.width, self.height);
}

#pragma mark - Setter

- (void)setFrame:(PersonFrame)frame {
    self.x = frame.x;
    self.y = frame.y;
    self.width = frame.width;
    self.height = frame.width;
}


@end