//
//  PPDetailViewController.m
//  P2P
//
//  Created by Tywin on 2017/12/28.
//  Copyright © 2017年 Tywin. All rights reserved.
//

#import "PPDetailViewController.h"
#import "PPDispatch.h"
#import "PPDetailMediaItem.h"
@interface PPDetailViewController ()
{
    
    __weak IBOutlet UILabel *_infoLabel;
    __weak IBOutlet UITableView *_itemTable;
    PPDetailMediaItem *_detailItem;
}
@end

@implementation PPDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    [self loadData];
}

- (void)loadData
{
    [PPDispatch detailBy:_href handle:^(id data, BOOL finish) {
        if(finish){
            _detailItem = (PPDetailMediaItem *)data;
            [self bindData];
        }
    }];
}

- (void)bindData
{
    _detailItem.name = _titleString;
    _detailItem.size = _sizeString;
    _detailItem.cdate = _cdate;
    _detailItem.hot = _hotString;
    NSString *infoString = [NSString stringWithFormat:@"%@\n\n磁力链:\n%@\n\n资源大小:  %@\n\n资源热度:  %@\n\n创建日期： %@",_detailItem.name,_detailItem.magent,_detailItem.size,_detailItem.hot,_detailItem.cdate];
    _infoLabel.text = infoString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
