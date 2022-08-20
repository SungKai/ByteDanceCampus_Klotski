//
//  Person.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

#import "Person.h"

#pragma mark - Person

@implementation Person

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        _name = dic[@"name"];
        _x = [dic[@"y"] intValue];
        _y = [dic[@"x"] intValue];
        _width = [dic[@"height"] intValue];
        _height = [dic[@"width"] intValue];
    }
    return self;
}

#pragma mark - <NSCopying>

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    Person *p = [[Person alloc] init];
    p.name = _name.copy;
    p.frame = self.frame;
    return p;
}

#pragma mark - Getter

- (PersonFrame)frame {
    return PersonFrameMake(_x, _y, _width, _height);
}

- (PersonType)type {
    if (_width == 1 && _height == 1) {
        return PersonTinySquare;
    }
    if (_width == 1 && _height == 2) {
        return PersonVertical;
    }
    if (_width == 2 && _height == 1) {
        return PersonHorizontal;
    }
    if (_width == 2 && _height == 2) {
        return PersonBigSquare;
    }
    return PersonFoo;
}

- (NSString *)code {
    return [NSString stringWithFormat:@"%d%d%d%d%@", _x, _y, _width, _height, _name];
}

- (PersonStruct)perStruct {
    PersonStruct per = {self.index, self.frame, self.type};
    return per;
}

#pragma mark - Setter

- (void)setFrame:(PersonFrame)frame {
    _x = frame.x;
    _y = frame.y;
    _width = frame.width;
    _height = frame.height;
}

@end
