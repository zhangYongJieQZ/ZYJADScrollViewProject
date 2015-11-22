//
//  GameModel.h
//  TestADScrollView
//
//  Created by 张永杰 on 15/10/25.
//  Copyright © 2015年 张永杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameModel : NSObject

@property (strong, nonatomic)NSString *jumpAddress;
@property (strong, nonatomic)NSString *imageAddress;
@property (strong, nonatomic)NSString *gameName;

-(instancetype)initWithName:(NSString *)name JumpStr:(NSString *)jumpStr imageStr:(NSString *)imageStr;

@end
