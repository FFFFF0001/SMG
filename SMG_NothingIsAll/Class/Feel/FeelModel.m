//
//  FeelModel.m
//  SMG_NothingIsAll
//
//  Created by 贾  on 2017/4/9.
//  Copyright © 2017年 XiaoGang. All rights reserved.
//

#import "FeelModel.h"
#import "TMCache.h"
#import "SMGHeader.h"

@interface FeelModel ()

@property (strong,nonatomic) NSMutableArray *attributesKeys;    //属性的keys数组;

@end

@implementation FeelModel



/**
 *  MARK:--------------------追加属性--------------------
 *  feelValueModel:比较值
 *  key:比的是什么;(key来自tmcache存的"FeelModel_Attributes_Keys")
 */
-(void) appendFeelValueModel:(FeelValueModel*)feelValueModel withKEY:(NSString*)key{
    if (feelValueModel && [self.attributesKeys containsObject:STRTOOK(key)]) {
        NSMutableArray *valueArr = [[NSMutableArray alloc] initWithArray:[self.attributes objectForKey:STRTOOK(key)]];
        [valueArr addObject:feelValueModel];
        [self.attributes setObject:valueArr forKey:STRTOOK(key)];
    }
}


/**
 *  MARK:--------------------propertys--------------------
 */
-(NSMutableArray *)attributesKeys{
    if (_attributesKeys == nil) {
        _attributesKeys = [[NSMutableArray alloc] initWithArray:[[TMCache sharedCache] objectForKey:@"FeelModel_Attributes_Keys"]];
    }
    return _attributesKeys;
}

-(void) addAttributesKey:(NSString*)key{
    [self.attributesKeys addObject:STRTOOK(key)];
    [[TMCache sharedCache] setObject:self.attributesKeys forKey:@"FeelModel_Attributes_Keys"];
}

-(NSMutableDictionary *)attributes{
    if (_attributes == nil) {
        _attributes = [[NSMutableDictionary alloc] init];
    }
    return _attributes;
}


@end
