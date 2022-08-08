//
//  RisingTableView.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/8.
//

#import "RisingTableView.h"

@implementation RisingTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
@end
