//
//  PPMagent.h
//  P2P
//
//  Created by Tywin on 2018/1/1.
//  Copyright © 2018年 Tywin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PPMagent : NSObject

@property(nonatomic, strong) NSString *status;
@property(nonatomic, strong) NSString *torrentUrl;
@property(nonatomic, strong) NSString *videoUrl;
@property(nonatomic, strong) NSMutableArray *files;
@property(nonatomic, strong) NSString *selectedFile;
@property(nonatomic, strong) NSString *hotswaps;
@property(nonatomic, strong) NSString *verified;
@property(nonatomic, strong) NSString *invalid;
@property(nonatomic, strong) NSString *filename;
@property(nonatomic, strong) NSString *size;
@property(nonatomic, strong) NSString *downloadSpeed;
@property(nonatomic, strong) NSString *downloaded;
@end
