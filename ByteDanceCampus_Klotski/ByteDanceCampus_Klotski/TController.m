//
//  TController.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/9.
//

#import "TController.h"

#import <CocoaMarkdown/CocoaMarkdown.h>

#pragma mark - TController ()

@interface TController ()

/// <#description#>
@property (nonatomic, strong) YYTextView *introduceTextView;

@end

@implementation TController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:self.introduceTextView];
}

#pragma mark - Method

// MARK: SEL

#pragma mark - Getter


- (YYTextView *)introduceTextView {
    if (_introduceTextView == nil) {
        _introduceTextView = [[YYTextView alloc] initWithFrame:CGRectMake(15, 15, self.view.width - 30, 400)];
        _introduceTextView.font = [UIFont fontWithName:PingFangSC size:14];
        _introduceTextView.textColor =
        [UIColor Any_hex:@"#112C54" a:1 Dark_hex:@"#F0F0F0" a:1];
        
        dispatch_async(dispatch_queue_create("Rising & SSR.ByteDance.StageTopView", DISPATCH_QUEUE_CONCURRENT), ^{
            CMDocument *document = [[CMDocument alloc] initWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"klotski" ofType:@"md"] options:15];
            NSAttributedString *string = [document attributedStringWithAttributes:[[CMTextAttributes alloc] init]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                self->_introduceTextView.attributedText = string;
            });
        });
    }
    return _introduceTextView;
}

#pragma mark - RisingRouterHandler

+ (NSArray<NSString *> *)routerPath {
    return @[
        @"TController"
    ];
}

+ (void)responseRequest:(RisingRouterRequest *)request completion:(RisingRouterResponseBlock)completion {
    
    RisingRouterResponse *response = [[RisingRouterResponse alloc] init];
    
    switch (request.requestType) {
        case RouterRequestPush: {
            
            UINavigationController *nav = (request.requestController ? request.requestController : RisingRouterRequest.useTopController).navigationController;
            
            if (nav) {
                TController *vc = [[self alloc] init];
                response.responseController = vc;
                
                [nav pushViewController:vc animated:YES];
            } else {
                
                response.errorCode = RouterResponseWithoutNavagation;
            }
            
        } break;
            
        case RouterRequestParameters: {
            // TODO: 传回参数
        } break;
            
        case RouterRequestController: {
            
            TController *vc = [[self alloc] init];
            
            response.responseController = vc;
        } break;
    }
    
    if (completion) {
        completion(response);
    }
}



@end
