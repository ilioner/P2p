//
//  PPRequest.m
//  P2P
//
//  Created by Tywin on 2017/12/26.
//  Copyright © 2017年 Tywin. All rights reserved.
//

#import "PPDetailRequest.h"

@implementation PPDetailRequest
{
    NSString *_href;
}

- (instancetype)initWith:(NSString *)href
{
    self = [super init];
    if (self) {
        _href = href;
    }
    return self;
}

- (NSString *)requestUrl {
    //http://www.btsoso.info/A6A0FFDDADA6A4A17C79A2275CBBD204BDFBAA1D.html
    // “ http://www.yuantiku.com ” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    //https://www.sobt8.com/q/%E7%BE%8E%E5%9B%BD%E9%98%9F%E9%95%BF.html?sort=rel&page=1
    //http://www.btsoso.info/search/%@_ctime_%@.html
    NSString *url = [NSString stringWithFormat:@"http://www.btsoso.info%@",_href];
    NSString *encodedValue = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodedValue;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}


- (YTKResponseSerializerType)responseSerializerType
{
    return YTKResponseSerializerTypeHTTP;
}

- (id)requestArgument {
    return nil;
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary
{
    
    return @{
             @"User-Agent":[self getUAString],
             };
}


- (NSString *)getUAString {
    
        NSArray * userAgents = @[@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36",
                                 @"Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36",
                                 @"Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:36.0) Gecko/20100101 Firefox/36.0",
                                 @"Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.94 Safari/537.36",
                                 @"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; en-US) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27"];
        return userAgents[arc4random() % userAgents.count];
}

@end
