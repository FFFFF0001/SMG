//
//  SMG.m
//  SMG_NothingIsAll
//
//  Created by 贾  on 2017/4/8.
//  Copyright © 2017年 XiaoGang. All rights reserved.
//

#import "SMG.h"
#import "SMGHeader.h"
#import "LanguageHeader.h"
#import "GC.h"
#import "StoreHeader.h"

@implementation SMG

static SMG *_instance;
+(SMG*) sharedInstance{
    if (_instance == nil) {
        _instance = [[SMG alloc] init];
    }
    return _instance;
}

-(id) init{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

-(void) initData{
    self.store = [[Store alloc] init];
    self.gc = [[GC alloc] init];
    self.language = [[Language alloc] init];
    self.mind = [[Mind alloc] init];
}

/**
 *  MARK:--------------------method--------------------
 */

//MARK:--------------------QA--------------------
-(void) requestWithText:(NSString*)text withComplete:(void (^)(NSString* response))complete{
    text = STRTOOK(text);
    //1,心情不好时,不回答,(需要安慰加心情值再聊)
    if (self.mind.sadHappyValue < -5) {
        if (complete)
            complete(@"🔥");
        return;
    }
    
    //2,搜记忆;
    StoreModel_Text *model = [self.store searchMemStoreWithLanguageText:text];
    
    //3,Language系统输出回复;
    if (complete)
        complete([self.language outputTextWithRequestText:text withStoreModel:model]);
}

-(void) requestWithJoyAngerType:(JoyAngerType)joyAngerType {
    //1,找到上关记忆;
    //2,有则根据mind值update记忆;
    //3,无则根据回复I can't undestand;
}


//MARK:--------------------Store--------------------
-(NSArray*) getStore_MemStore_MemArr{
    return self.store.memStore.memArr;
}



@end
