//
//  PPMagentRequest.m
//  P2P
//
//  Created by Tywin on 2018/1/1.
//  Copyright © 2018年 Tywin. All rights reserved.
//

#import "PPMagentRequest.h"

@implementation PPMagentRequest
{
    NSString *_magent;
}
- (id)initWith:(NSString *)magent
{
    self = [super init];
    if (self){
        _magent = magent;
    }
    return self;
}

- (NSString *)requestUrl {
    // “ http://www.yuantiku.com ” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    //https://www.sobt8.com/q/%E7%BE%8E%E5%9B%BD%E9%98%9F%E9%95%BF.html?sort=rel&page=1
    //http://www.btsoso.info/search/%@_ctime_%@.html
    NSString *url = @"http://127.0.0.1:9870/torrent/play";
    NSString *encodedValue = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodedValue;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}


- (YTKResponseSerializerType)responseSerializerType
{
    return YTKResponseSerializerTypeJSON;
}

- (id)requestArgument {
    return @{@"url":_magent};
}
@end
