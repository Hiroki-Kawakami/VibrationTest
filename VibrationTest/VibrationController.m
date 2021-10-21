//
//  VibrationController.m
//  VibrationTest
//
//  Created by hiroki on 2016/05/31.
//  Copyright © 2016年 hiroki. All rights reserved.
//

#import "VibrationController.h"

@implementation VibrationController

void AudioServicesPlaySystemSoundWithVibration(int, id, NSDictionary *);
static NSMutableSet<NSTimer*> *timers;

+(void)startVibrationWithDuration:(double)duration {
    [self stopVibration];
    
    int64_t vibrationLength = duration*1000;
    NSArray *pattern = @[@NO, @0, @YES, @(vibrationLength)];

    NSMutableDictionary* dict = @{
        @"VibePattern": pattern,
        @"Intensity": @1,
    }.mutableCopy;
    
    AudioServicesPlaySystemSoundWithVibration(kSystemSoundID_Vibrate,nil,dict);
}

+(void)startVibrationWithDurations:(NSArray<NSNumber *> *)durations {
    [self stopVibration];
    double delay = 0;
    for (NSInteger i = 0; i + 1 < durations.count; i+=2) {
        delay = durations[i].doubleValue;
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(timerMethod:) userInfo:@{@"long":durations[i+1]} repeats:false];
        [timers addObject:timer];
    }
}

+(void)startVibrationWithDuration:(double)duration Interval:(double)interval Repeat:(NSInteger)repeat {
    [self stopVibration];
    for (NSInteger i = 0 ; i < repeat; i++) {
        double delay = interval*i;
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(timerMethod:) userInfo:@{@"long":[NSNumber numberWithDouble:duration]} repeats:false];
        [timers addObject:timer];
    }
}

+(void)stopVibration {
    if (timers) {
        for (NSTimer *timer in timers) {
            [timer invalidate];
        }
        [timers removeAllObjects];
    }
    else {
        timers = [NSMutableSet set];
    }
}

+(void)timerMethod:(NSTimer*)timer {
    NSNumber *num = timer.userInfo[@"long"];
    [self startVibrationWithDuration:num.doubleValue];
}

@end
