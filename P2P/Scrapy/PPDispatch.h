//
//  PPDispatch.h
//  P2P
//
//  Created by Tywin on 2017/12/26.
//  Copyright © 2017年 Tywin. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

typedef void(^dispatch)(id data,BOOL finish);

@interface PPDispatch : YTKRequest

+(id)dataBy:(NSString *)keywords page:(NSString *)page handle:(dispatch)dispatch;

+(void)detailBy:(NSString *)url handle:(dispatch)dispatch;
@end
