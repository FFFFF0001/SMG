//
//  SMG.m
//  SMG_NothingIsAll
//
//  Created by 贾  on 2017/4/8.
//  Copyright © 2017年 XiaoGang. All rights reserved.
//

#import "SMG.h"

@implementation SMG

static SMG *_instance;
+(id) sharedInstance{
    if (_instance == nil) {
        _instance = [[SMG alloc] init];
    }
    return _instance;
}

/**
 *  MARK:--------------------问话--------------------
 */
-(void) requestWithText:(NSString*)test withComplete:(void (^)(NSString* response))complete{
    //1,搜记忆;
    //2,有则根据mind值回复;
    //3,无则根据mind值回复;
}

-(void) requestWithJoyAngerType:(JoyAngerType)joyAngerType {
    //1,找到上关记忆;
    //2,有则根据mind值update记忆;
    //3,无则根据回复I can't undestand;
}

@end
