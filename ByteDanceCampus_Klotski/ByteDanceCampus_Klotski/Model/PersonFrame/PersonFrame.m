//
//  PersonFrame.m
//  ByteDanceCampus_Klotski
//
//  Created by SSR on 2022/8/4.
//

#import <Foundation/Foundation.h>

NSString *NSStringFromPersonFrame(PersonFrame frame) {
    return [NSString stringWithFormat:@"{%d %d %d %d}", frame.x, frame.y, frame.width, frame.height];
}
