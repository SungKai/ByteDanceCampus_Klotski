//
//  IntroduceView.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/11.
//

#import "IntroduceView.h"

#import <CocoaMarkdown/CocoaMarkdown.h>

@implementation IntroduceView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 20;
        self.clipsToBounds = YES;
        self.font = [UIFont fontWithName:PingFangSC size:14];
        
        dispatch_async(dispatch_queue_create("Rising & SSR.ByteDance.Introduce", DISPATCH_QUEUE_CONCURRENT), ^{
            CMDocument *document = [[CMDocument alloc] initWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"klotski" ofType:@"md"] options:15];
            NSAttributedString *string = [document attributedStringWithAttributes:[[CMTextAttributes alloc] init]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.attributedText = string;
            });
        });
    }
    return self;
}

#pragma mark - Method

- (void)drawRect:(CGRect)rect {
    if (rect.size.height < 20) {
        self.alpha = 0;
    } else if (rect.size.height >= 20 && rect.size.height <= 70) {
        self.alpha = rect.size.height / 50;
    } else {
        self.alpha = 1;
    }
    
    static float height = 0;
    static BOOL down = YES;
    if (rect.size.height < height) {
        if (rect.size.height > 50 && down) {
            UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
            [generator impactOccurred];
            down = NO;
        }
    } else {
        if (rect.size.height > 50 && !down) {
            down = YES;
        }
    }
    
    height = rect.size.height;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
