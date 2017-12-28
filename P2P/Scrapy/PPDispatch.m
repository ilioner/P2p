//
//  PPDispatch.m
//  P2P
//
//  Created by Tywin on 2017/12/26.
//  Copyright © 2017年 Tywin. All rights reserved.
//

#import "PPDispatch.h"
#import "PPPageParse.h"
#import "PPRequest.h"

@implementation PPDispatch


+ (id)dataBy:(NSString *)keywords page:(NSString *)page handle:(dispatch)dispatch
{
    //1 调度请求驱动
    
    //2 调度页面解析服务
//    keywords = @"美国队长";
    PPRequest *request = [[PPRequest alloc] initWith:keywords page:page];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (request){
            //NSLog(@"%@",request.responseString);
            NSString *htmlString = request.responseString;
            [PPPageParse parse:htmlString keywords:keywords handle:^(id data, BOOL finish) {
                dispatch(data,finish);
            }];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (request){
            //NSLog(@"%@",request.error);
            dispatch(NULL,NO);
        }
    }];
    return NULL;
}

@end
