//
//  PPRequest.h
//  P2P
//
//  Created by Tywin on 2017/12/26.
//  Copyright © 2017年 Tywin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKNetwork.h>

@interface PPRequest : YTKRequest

- (id)initWith:(NSString *)keywords page:(NSString *)page;

@end
