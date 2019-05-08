//
//  VibrationController.m
//  VibrationTest
//
//  Created by hiroki on 2016/05/31.
//  Copyright © 2016年 hiroki. All rights reserved.
//

#import "VibrationController.h"

@implementation VibrationController

static NSMutableSet<NSTimer*> *timers;

+(void)startVibrationWithDuration:(double)duration {
    [self stopVibration];
    
    void (*vibrate)(int, void *, id);
    vibrate = dlsym(RTLD_SELF, @"AudioServicesPlaySystemSoundWithVibration".UTF8String);
    
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    NSMutableArray* arr = [NSMutableArray array];
    
    [arr addObject:[NSNumber numberWithBool:YES]];
    [arr addObject:[NSNumber numberWithInt:duration*1000]];
    
    [dict setObject:arr forKey:@"VibePattern"];
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"Intensity"];
    
    vibrate(4095,nil,dict);
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
