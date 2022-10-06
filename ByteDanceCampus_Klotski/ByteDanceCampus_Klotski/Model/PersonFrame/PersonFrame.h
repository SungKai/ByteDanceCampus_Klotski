//
//  PersonFrame.h
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

#ifndef PersonFrame_h
#define PersonFrame_h

typedef struct _PersonFrame {
    int x;
    int y;
    int width;
    int height;
} PersonFrame;

NS_INLINE PersonFrame PersonFrameMake(int x, int y, int width, int height) {
    PersonFrame frame = {x, y, width, height};
    return frame;
}

NS_INLINE BOOL PersonFrameEqual(PersonFrame f1, PersonFrame f2) {
    return (    f1.x == f2.x     &&      f1.y == f2.y     &&
            f1.width == f2.width && f1.height == f2.height);
}

FOUNDATION_EXPORT NSString *NSStringFromPersonFrame(PersonFrame);

#pragma mark - ENUM (PersonDirrection)

typedef NS_ENUM(NSUInteger, PersonDirection) {
    PersonDirectionRight, // 右  0
    PersonDirectionLeft,  // 左  1
    PersonDirectionUP,    // 上  2
    PersonDirectionDown   // 下  3
};

#endif /* PersonFrame_h */
