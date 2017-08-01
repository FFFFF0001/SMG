//
//  MindControll.m
//  SMG_NothingIsAll
//
//  Created by 贾  on 2017/5/6.
//  Copyright © 2017年 XiaoGang. All rights reserved.
//

#import "MindControl.h"
#import "MindHeader.h"
#import "ThinkHeader.h"
#import "MBProgressHUD+Add.h"
#import "OutputHeader.h"

@interface MindControl ()<MineDelegate>

@property (strong,nonatomic) Awareness *awareness;

@end

@implementation MindControl

-(id) init{
    self = [super init];
    if (self) {
        [self initData];
        [self initRun];
    }
    return self;
}

-(void) initData{
    self.mine = [[Mine alloc] init];
    self.awareness = [[Awareness alloc] init];
}

-(void) initRun{
    self.mine.delegate = self;
    [self.awareness run];
}

/**
 *  MARK:--------------------method--------------------
 */
-(id) getMindValue:(AIPointer*)pointer{
    //xxx这个值还没存;
    int moodValue = (random() % 2) - 1;//所有demand只是简单规则;即将value++;
    if (moodValue < 0) {
        //[theThink commitMindValueNotice:nil withType:0];//@"怼他" withType:MindType_Angry
    }else{
        //[theThink commitMindValueNotice:nil withType:0];//@"大笑" withType:MindType_Happy];
    }
    
    //*  value:数据类型未定;
    //*      1,从经验和长期记忆搜索有改变mindValue的记录;
    //*      2,根据当前自己的状态;
    //*      3,计算出一个值;并返回;
    return nil;
}

-(void) turnDownDemand:(AIDemandModel*)model{
    if (model) {
        [theMood setData:model.value type:MoodType_Irritably2Calm rateBlock:^(Mood *mood) {
            [theOutput output_Face:MoodType_Irritably2Calm value:mood.value];
        }];
    }
}

/**
 *  MARK:--------------------MineDelegate--------------------
 */
-(void) mine_HungerLevelChanged:(AIHungerLevelChangedModel*)model{
    if (model) {
        //1,转换model;
        AIMindValueModel *mindValue = [MindValueUtils getMindValue_HungerLevelChanged:model];
        //2,分析决策 & 产生需求
        if (model.state == UIDeviceBatteryStateCharging) {
            [AIMindValueStore insert:mindValue awareness:true];//logThink记忆饿的感觉
            [theThink commitMindValueNotice:mindValue];
        }else if (model.state == UIDeviceBatteryStateUnplugged) {
            if (mindValue.value < -3) {
                [AIMindValueStore insert:mindValue awareness:true];//logThink记忆饿的感觉
                [theThink commitMindValueNotice:mindValue];
            }
        }
    }
}

-(void) mine_HungerStateChanged:(AIHungerStateChangedModel*)model{
    if (model) {
        //1,转换model;
        AIMindValueModel *mindValue = [MindValueUtils getMindValue_HungerLevelChanged:model];
        
        //1,查询当前未处理的需求;看有没被解决掉;
        //2,思考充电状态与电量增加的逻辑关系;
        //3,充上电,只会记录状态变化;而充上电加电后,才会真正知道充上电与充电的逻辑关系;
        [theThink commitMindValueNotice:mindValue];
        
        //2,分析决策 & 产生需求
        if (model.state == HungerState_Unplugged) {
            if (model.level > 9.5) {
                [MBProgressHUD showSuccess:@"饱了..." toView:nil withHideDelay:1];
            }else if(model.level > 7){
                [MBProgressHUD showSuccess:@"好吧,下次再充..." toView:nil withHideDelay:1];
            }else if(model.level < 7){
                [MBProgressHUD showSuccess:@"还没饱呢" toView:nil withHideDelay:1];
            }
        }else if (model.state == HungerState_Charging) {
            if (model.level > 9.5) {
                [MBProgressHUD showSuccess:@"饱了..." toView:nil withHideDelay:1];
            }else if(model.level > 7){
                [MBProgressHUD showSuccess:@"好吧,再充些..." toView:nil withHideDelay:1];
            }else if(model.level < 7){
                [MBProgressHUD showSuccess:@"谢谢呢!" toView:nil withHideDelay:1];
            }
        }
    }
}

@end
