//
//  PPItemCell.m
//  P2P
//
//  Created by Tywin on 2017/12/27.
//  Copyright © 2017年 Tywin. All rights reserved.
//

#import "PPItemCell.h"

@implementation PPItemCell
{
    
    __weak IBOutlet UILabel *_title;
    __weak IBOutlet UILabel *_info;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(PPMediaItem *)item
{
    _item = item;
    _title.text = item.name;
    _info.text = [NSString stringWithFormat:@"更新日期:%@  资源大小:%@  下载热度:%@",item.cdate,item.size,item.hot];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
