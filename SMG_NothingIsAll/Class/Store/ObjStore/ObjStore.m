//
//  ObjStore.m
//  SMG_NothingIsAll
//
//  Created by 贾  on 2017/4/23.
//  Copyright © 2017年 XiaoGang. All rights reserved.
//

#import "ObjStore.h"
#import "SMG.h"
#import "StoreHeader.h"
#import "SMGHeader.h"
#import "TMCache.h"

@interface ObjStore ()

/**
 *  MARK:--------------------分词数组--------------------
 *
 *  结构:
 *      (DIC | Key:itemName Value:str | Key:itemId Value:NSInteger )注:itemId为主键;
 *
 *  元素:
 *      (实物对象,如人,苹果等);
 *
 */
@property (strong,nonatomic) NSMutableArray *dataArr;


@end

@implementation ObjStore



/**
 *  MARK:--------------------public--------------------
 */
//精确匹配某词
-(NSDictionary*) getSingleItemWithItemName:(NSString*)itemName{
    return [self getSingleItemWithWhere:[NSDictionary dictionaryWithObjectsAndKeys:STRTOOK(itemName),@"itemName", nil]];
}

//获取where的最近一条;(精确匹配)
-(NSDictionary*) getSingleItemWithWhere:(NSDictionary*)whereDic{
    //数据检查
    if (whereDic == nil || whereDic.count == 0) {
        return nil;
    }
    for (NSInteger i = self.dataArr.count - 1; i >= 0; i--) {
        NSDictionary *item = self.dataArr[i];
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

/**
 *  MARK:--------------------addItem--------------------
 */
-(NSDictionary*) addItem:(NSString*)itemName{
    //去重
    if (itemName) {
        NSString *itemId = [NSString stringWithFormat:@"%ld",[self createItemId]];
        NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:STRTOOK(itemName),@"itemName",itemId,@"itemId", nil];
        [self.dataArr addObject:item];
        [self saveToLocal];
        return item;
    }
    return nil;
}

-(NSMutableArray*) addItemNameArr:(NSArray*)itemNameArr{
    //去重
    NSMutableArray *valueArr = nil;
    if (ARRISOK(itemNameArr)) {
        NSInteger itemId = [self createItemId:itemNameArr.count];//申请itemNameArr.count个itemId
        for (NSString *itemName in itemNameArr) {
            if (valueArr == nil) valueArr = [[NSMutableArray alloc] init];
            NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:STRTOOK(itemName),@"itemName",[NSString stringWithFormat:@"%ld",itemId],@"itemId", nil];
            [valueArr addObject:item];
            itemId ++;
        }
        [self.dataArr addObjectsFromArray:valueArr];
        [self saveToLocal];
    }
    return valueArr;
}


/**
 *  MARK:--------------------private--------------------
 */
-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] initWithArray:[self getLocalArr]];
    }
    return _dataArr;
}

//硬盘存储;(不常调用,调用耗时)
-(NSArray*) getLocalArr{
    return [[TMCache sharedCache] objectForKey:@"MKStore_Obj_DataArr_Key"];
}

-(void) saveToLocal{
    [[TMCache sharedCache] setObject:self.dataArr forKey:@"MKStore_Obj_DataArr_Key"];
}

-(NSInteger) createItemId{
    return [self createItemId:1];
}

-(NSInteger) createItemId:(NSInteger)limit{
    limit = MAX(0, limit);
    NSInteger lastId = [[NSUserDefaults standardUserDefaults] integerForKey:@"MKStore_Obj_ObjId"];
    [[NSUserDefaults standardUserDefaults] setInteger:lastId + limit forKey:@"MKStore_Obj_ObjId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return lastId + limit;
}



@end
