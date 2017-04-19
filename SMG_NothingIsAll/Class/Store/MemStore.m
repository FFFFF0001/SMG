//
//  MemStore.m
//  SMG_NothingIsAll
//
//  Created by 贾  on 2017/4/7.
//  Copyright © 2017年 XiaoGang. All rights reserved.
//

#import "MemStore.h"
#import "TMCache.h"
#import "SMGHeader.h"


@interface MemStore ()

@property (strong,nonatomic) NSMutableArray *memArr;  //内存kv存储;(数组中存StoreModel_Text对象)(习惯记忆,GC会回收不常用的旧数据到localArr)

@end


@implementation MemStore


/**
 *  MARK:--------------------private--------------------
 */
-(NSMutableArray *)memArr{
    if (_memArr == nil) {
        _memArr = [[NSMutableArray alloc] initWithArray:[self getLocalArr]];
    }
    return _memArr;
}



//硬盘存储;(不常调用,调用耗时)
-(NSArray*) getLocalArr{
    return [[TMCache sharedCache] objectForKey:@"MemStore_LocalArr_Key"];
}


/**
 *  MARK:--------------------public--------------------
 */
-(NSDictionary*) getLastMemory{
    return [self.memArr lastObject];
}

-(NSDictionary*) getPreviousMemory:(NSDictionary*)mem{
    if (mem) {
        NSInteger memIndex = [self.memArr indexOfObject:mem];
        if (memIndex > 0) {
            return self.memArr[memIndex - 1];
        }
    }
    return nil;
}

-(NSDictionary*) getNextMemory:(NSDictionary*)mem{
    if (mem) {
        NSInteger memIndex = [self.memArr indexOfObject:mem];
        if (memIndex >= 0 && memIndex < self.memArr.count - 1) {
            return self.memArr[memIndex + 1];
        }
    }
    return nil;
}

-(NSDictionary*) getSingleMemoryWithWhereDic:(NSDictionary*)whereDic{
    //数据检查
    if (whereDic == nil || whereDic.count == 0) {
        return [self getLastMemory];
    }
    for (NSInteger i = self.memArr.count - 1; i >= 0; i--) {
        NSDictionary *item = self.memArr[i];
        BOOL isEqual = true;
        //对比所有value;
        for (NSString *key in whereDic.allKeys) {
            if (![SMGUtils compareItemA:[item objectForKey:key] itemB:[whereDic objectForKey:key]]) {
                isEqual = false;
            }
        }
        //都一样,则返回;
        if (isEqual) {
            return item;
        }
    }
    return nil;
}

-(NSArray*) getMemoryWithWhereDic:(NSDictionary*)whereDic{
    //数据检查
    if (whereDic == nil || whereDic.count == 0) {
        return self.memArr;
    }
    NSMutableArray *valArr = nil;
    for (NSInteger i = self.memArr.count - 1; i >= 0; i--) {
        NSDictionary *item = self.memArr[i];
        BOOL isEqual = true;
        //对比所有value;
        for (NSString *key in whereDic.allKeys) {
            if (![SMGUtils compareItemA:[item objectForKey:key] itemB:[whereDic objectForKey:key]]) {
                isEqual = false;
            }
        }
        //都一样,则收集到valArr;
        if (isEqual) {
            if (valArr == nil) {
                valArr = [[NSMutableArray alloc] init];
            }
            [valArr addObject:item];
        }
    }
    return valArr;
}



-(void) addMemory:(NSDictionary*)mem{
    if (mem) {
        [self.memArr addObject:mem];
        [self saveToLocal];
    }
}

-(void) addMemory:(NSDictionary*)mem insertFrontByMem:(NSDictionary*)byMem{
    if (mem && byMem) {
        NSInteger byMemIndex = [self.memArr indexOfObject:byMem];
        if (byMemIndex > 0) {
            [self.memArr insertObject:mem atIndex:byMemIndex - 1];
            [self saveToLocal];
        }
    }
}

-(void) addMemory:(NSDictionary*)mem insertBackByMem:(NSDictionary*)byMem{
    if (mem && byMem) {
        NSInteger byMemIndex = [self.memArr indexOfObject:byMem];
        if (byMemIndex > 0) {
            if (byMemIndex < self.memArr.count - 1) {
                [self.memArr insertObject:mem atIndex:byMemIndex + 1];
            }else{
                [self.memArr addObject:mem];
            }
            [self saveToLocal];
        }
    }
}

-(void) saveToLocal{
    [[TMCache sharedCache] setObject:self.memArr forKey:@"MemStore_LocalArr_Key"];
}

@end
