//
//  Decision.m
//  SMG_NothingIsAll
//
//  Created by 贾  on 2017/5/27.
//  Copyright © 2017年 XiaoGang. All rights reserved.
//

#import "Decision.h"
#import "MindHeader.h"

@interface Decision ()

@property (strong,nonatomic) NSMutableDictionary *mDic; //数据;

@end


@implementation Decision


/**
 *  MARK:--------------------Mind引擎的需求 分析 & 决策--------------------
 *  Mind->Decision->FeelOut->Output
 */
-(void) commitDemand:(id)demand withType:(MindType)type{
    NSLog(@"1,提交需求...To...Decision");
    NSLog(@"2,分析决策 Mind的需求 ");
    NSLog(@"3,分析理解Mind需求,作出下步行为输出");
    
    
    
    if (type == MindType_Angry) {
        NSLog(@"我很生气!");
        NSLog(@"我要:%@",demand);
    }else if (type == MindType_Happy) {
        NSLog(@"我很开心!");
        NSLog(@"我要:%@",demand);
    }
    
    //1,从(记忆,经验习惯和知识)里找到解决方式;
    //  1.1,注:每一步都要受到(Mood,Hobby,Mine)的影响;
    //  1.2,找不到分析(获取注意力|作为火花塞点燃mind)(转2)
    //  1.3,找到则执行(转3)
    //2,decision分析
    //3,执行;
    //  3.1,注:最终决策要交由Mind作最后命令;
    //4,结果;
    //  4.1,反馈给mindControl;
    
    
    //?解决饿的问题
    if (type == MindType_Hunger) {
        //1,找吃的
        //1.1,找到与吃的最相关的东西;(如冰箱)
//        AILaw
        
        
        //分析当前的饥饿状态 & 记到"意识流";
        //找相关记忆,如果找不到则直接表达情绪;
        //xxxx
        
        CGFloat mindValueDelta = [NUMTOOK(demand) floatValue];
        if (fabsf(mindValueDelta) > 1) {
            AIMindValue *mindValue = [[AIMindValue alloc] init];
            mindValue.type = type;
            mindValue.value = mindValueDelta;
            [AIMindValue ai_insertToDB:mindValue];//logThink
            
            
            //1,搜索强化经验(经验表)
            BOOL experienceValue = true;
            if (experienceValue) {
                //1),参照解决方式,
                //2),类比其常识,
                //3),制定新的解决方式,
                //4),并分析其可行性, & 修正
                //5),预测其结果;(经验中上次的步骤对比)
                //6),执行输出;
            }else{
                //2,搜索未强化经历(意识流)
                BOOL memValue = true;
                if (memValue) {
                    //1),参照记忆,
                    //2),尝试执行输出;
                    //3),反馈(观察整个执行过程)
                    //4),强化(哪些步骤是必须,哪些步骤是有关,哪些步骤是无关)
                    //5),转移到经验表;
                }else{
                    //1),取原始情绪表达方式(哭,笑)
                    //2),执行输出;
                    //3),记忆(观察整个执行过程)
                }
            }
            //注:执行输出并非执行结束,任务达成才是结果;(输出只是执行的一部分)
        }
        
        
        
    }
    
    //?:SMG的觉醒
    //1,无法跳过input来实现理解世界(机器已经有了听视文字三觉,只是与人类不同)
    //2,所有的数据有模糊到清晰的过程
    //3,决策无经验,则用原始方式;
    //4,假设SMG面对与人类完全不同的世界;只能通过输出文本和表情符来与世界沟通;而通过输入文本来交流;
    
    
    
    //logic表结构分析:mindType,mindValue,pointerArr;
    //1,单需求时,直接通过先天定义的急哭就可以解决;
    //2,多样需求时,就有了交互;交互是互相试探的过程;(并且试探过程会存为经验logic)
    //3,logic只存有指针;指向memory(长期情景记忆)
    //4,If(a,b=>c); 然后: b!>c; 则:a=>c;
    
    
    
    //数据
    //1,input时输入了一切 & 放到回放池;
    //2,作浅理解;
    //3,获得注意力 & 拍照;
    //4,存深理解内容,存记忆内容,存快照;
    //5,遗忘策略,4小时忘60%,24小时再忘20%;
    
    
    
    
    
    
}

@end
