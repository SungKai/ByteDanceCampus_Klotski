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

#endif /* PersonFrame_h */
