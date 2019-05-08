//
//  VibrationController.h
//  VibrationTest
//
//  Created by hiroki on 2016/05/31.
//  Copyright © 2016年 hiroki. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#include <dlfcn.h>

@interface VibrationController : NSObject

+(void)startVibrationWithDuration:(double)duration;
+(void)startVibrationWithDuration:(double)duration Interval:(double)interval Repeat:(NSInteger)repeat;
+(void)startVibrationWithDurations:(NSArray<NSNumber *> *)durations;

@end
