//
//  MemStore.h
//  SMG_NothingIsAll
//
//  Created by 贾  on 2017/4/7.
//  Copyright © 2017年 XiaoGang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  MARK:--------------------记忆存储--------------------
 *  1,MemStore.memArr是内存kv存储;
 *  2,MemStore的TMCache中有localKV存储;
 */
@interface MemStore : NSObject


-(NSDictionary*) getLastMemory;                         //获取最后一条;
-(NSDictionary*) getPreviousMemory:(NSDictionary*)mem;  //获取mem的上一条;
-(NSDictionary*) getNextMemory:(NSDictionary*)mem;      //获取mem的下一条;

-(void) addMemory:(NSDictionary*)mem;                   //新增一条
-(void) addMemoryToFront:(NSDictionary*)mem;            //新增一条到mem前面;
-(void) addMemoryToBack:(NSDictionary*)mem;             //新增一条到mem后面;

-(void) saveToLocal;

@end
