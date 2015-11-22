//
//  GameModel.m
//  TestADScrollView
//
//  Created by 张永杰 on 15/10/25.
//  Copyright © 2015年 张永杰. All rights reserved.
//

#import "GameModel.h"

@implementation GameModel

-(instancetype)initWithName:(NSString *)name JumpStr:(NSString *)jumpStr imageStr:(NSString *)imageStr{
    if (self = [super init]) {
        self.gameName = name;
        self.jumpAddress = jumpStr;
        self.imageAddress = imageStr;
    }
    return self;
}

@end
