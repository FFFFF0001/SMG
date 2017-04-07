//
//  MemStore.m
//  SMG_NothingIsAll
//
//  Created by 贾  on 2017/4/7.
//  Copyright © 2017年 XiaoGang. All rights reserved.
//

#import "MemStore.h"
#import "TMCache.h"



@implementation MemStore

static MemStore *instance;
+(id) sharedInstance{
    if (instance == nil) {
        instance = [[MemStore alloc] init];
    }
    return instance;
}


-(NSMutableDictionary *)dic{
    if (_dic == nil) {
        _dic = [NSMutableDictionary dictionaryWithDictionary:[[TMDiskCache sharedCache] objectForKey:@"MemStore_Dic_Key"]];
    }
    return _dic;
}

@end
