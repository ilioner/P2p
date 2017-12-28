//
//  PPMediaItem.h
//  P2P
//
//  Created by Tywin on 2017/12/27.
//  Copyright © 2017年 Tywin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPMediaItem : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *href;
@property(nonatomic,strong) NSString *idString;
@property(nonatomic,strong) NSString *size;
@property(nonatomic,strong) NSString *hot;
@property(nonatomic,strong) NSString *cdate;
@end
