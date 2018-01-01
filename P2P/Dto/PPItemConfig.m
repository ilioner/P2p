//
//  PPItemConfig.m
//  P2P
//
//  Created by Tywin on 2018/1/1.
//  Copyright © 2018年 Tywin. All rights reserved.
//

#import "PPItemConfig.h"
#import "PPMagent.h"
#import "PPFile.h"

@implementation PPItemConfig

+(void)load{
    [PPMagent mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"files" : @"PPFile"
                 };
    }];
}

@end
