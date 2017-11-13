//
//  main.m
//  SMG_NothingIsAll
//
//  Created by 贾  on 2017/4/7.
//  Copyright © 2017年 XiaoGang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AIAwareness.h"

int main(int argc, char * argv[]) {
    
    AIAwareness *awareness = [AIAwareness shareInstance];
    [awareness awake];
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
