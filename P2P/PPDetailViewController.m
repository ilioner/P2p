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
#import "PPMagentRequest.h"

#import "JXcore.h"
#import "PPMagent.h"
#import "PPItemConfig.h"
#import "PPPlayerViewController.h"
@interface PPDetailViewController ()
{
    
    __weak IBOutlet UILabel *_infoLabel;
    __weak IBOutlet UITableView *_itemTable;
    PPDetailMediaItem *_detailItem;
    __weak IBOutlet UIProgressView *_mainProgress;
    __weak IBOutlet UILabel *_pLabel;
    PPMagent *_magent;
    __weak IBOutlet UIButton *_play;
}
@end

@implementation PPDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    [self loadData];
    _play.hidden = YES;
    // Define ScreenBrightness method to JS side so we can call it from there (see app.js)
    [JXcore addNativeBlock:^(NSArray *params, NSString *callbackId) {
        NSLog(@"====>state chage %@",params);
//        [self loadData];
        _magent = [PPMagent mj_objectWithKeyValues:params[0]];
        [self updateValue];
    } withName:@"UpdateTorrentState"];
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

- (IBAction)onStart:(UIButton *)sender {
//    _detailItem.magent = @"magnet:?xt=urn:btih:64CCA0F2DA143903ACC1C713FE06EC1693E28663";
    PPMagentRequest *request = [[PPMagentRequest alloc] initWith:_detailItem.magent];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        

        NSLog(@"成功--->%@",request.responseString);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"失败--->%@",request.responseString);
        
    }];
}

- (void)updateValue
{
    if([_magent.size isEqualToString:@"0"]){
        return;
    }
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue,^{
        CGFloat p = _magent.downloaded.floatValue/_magent.size.floatValue;
        if (p!=0){
            _play.hidden = NO;
        }
        NSString *progress = [NSString stringWithFormat:@"%.1f%@",p*100,@"%"];
        _pLabel.text = progress;
        _mainProgress.progress = p;
    });
    
}

-(IBAction)startPlay
{
    PPPlayerViewController *player = [self.storyboard instantiateViewControllerWithIdentifier:@"PPPlayerViewController"];
    player.url = _magent.videoUrl;
    [self.navigationController pushViewController:player animated:YES];
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
