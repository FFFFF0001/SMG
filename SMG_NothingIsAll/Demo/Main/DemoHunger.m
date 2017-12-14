//
//  DemoHunger.m
//  SMG_NothingIsAll
//
//  Created by 贾  on 2017/12/14.
//  Copyright © 2017年 XiaoGang. All rights reserved.
//

#import "DemoHunger.h"
#import "MindHeader.h"
#import "Input.h"
#import "AIIMVHunger.h"

@interface DemoHunger ()

@end

@implementation DemoHunger

-(id) init{
    self = [super init];
    if (self) {
        [self initRun];
    }
    return self;
}

-(void) initRun{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observerHungerLevelChanged:) name:UIDeviceBatteryLevelDidChangeNotification object:nil];
}

/**
 *  MARK:--------------------method--------------------
 */
-(void) observerHungerLevelChanged:(NSNotification*)notification{
    //1,取值
    CGFloat level = [MathUtils getZero2TenWithOriRange:UIFloatRangeMake(0, 1) oriValue:[UIDevice currentDevice].batteryLevel];
    
    //2,传给Input
    AIIMVHunger *model = [[AIIMVHunger alloc] init];
    model.level = level;
    [theInput commitModel:model];
}

-(void) commit:(CGFloat)level {
    AIIMVHunger *model = [[AIIMVHunger alloc] init];
    model.level = level;
    [theInput commitModel:model];
}

@end

