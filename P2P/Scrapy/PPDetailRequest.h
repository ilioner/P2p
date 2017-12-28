//
//  PPRequest.h
//  P2P
//
//  Created by Tywin on 2017/12/26.
//  Copyright © 2017年 Tywin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKNetwork.h>

@interface PPDetailRequest : YTKRequest

- (instancetype)initWith:(NSString *)href;

@end
