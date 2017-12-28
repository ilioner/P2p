//
//  PPPageParse.h
//  P2P
//
//  Created by Tywin on 2017/12/26.
//  Copyright © 2017年 Tywin. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^parsehandle)(id data,BOOL finish);
@interface PPPageParse : NSObject

+(id)parse:(NSString *)pageString handle:(parsehandle)handle;
+(id)parseDetail:(NSString *)pageString handle:(parsehandle)handle;
@end
