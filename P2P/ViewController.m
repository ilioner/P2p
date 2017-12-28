//
//  ViewController.m
//  P2P
//
//  Created by Tywin on 2017/12/26.
//  Copyright © 2017年 Tywin. All rights reserved.
//

#import "ViewController.h"
#import "JXcore.h"
#import "PPDispatch.h"
#import "PPItemCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "PPDetailViewController.h"



static void callback(NSArray *args, NSString *return_id) { }

@interface ViewController ()
{
    __weak IBOutlet UISearchBar *_mainSearch;
    NSMutableArray *itemList;
    __weak IBOutlet UITableView *_mainTableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"PPItemCell" bundle:nil];
    [_mainTableView registerNib:nib forCellReuseIdentifier:@"PPItemCell"];
    [PPDispatch dataBy:@"归来" page:@"1" handle:^(id data, BOOL finish) {
        if (finish) {
            [self setDataList:(NSMutableArray *)data];
        }
    }];
    /*
    // Do any additional setup after loading the view, typically from a nib.
    // makes JXcore instance running under it's own thread
    [JXcore useSubThreading];
    
    // start engine (main file will be JS/main.js. This is the initializer file)
    [JXcore startEngine:@"JS/main"];
    
    // Define ScreenBrightness method to JS side so we can call it from there (see app.js)
    [JXcore addNativeBlock:^(NSArray *params, NSString *callbackId) {
        CGFloat br = [[UIScreen mainScreen] brightness];
        
        [JXcore callEventCallback:callbackId withJSON:[NSString stringWithFormat:@"%f", (float)br]];
    } withName:@"ScreenBrightness"];
    
    // Listen to Errors on the JS land
    [JXcore addNativeBlock:^(NSArray *params, NSString *callbackId) {
        NSString *errorMessage = (NSString*)[params objectAtIndex:0];
        NSString *errorStack = (NSString*)[params objectAtIndex:1];
        
        NSLog(@"Error!: %@\nStack:%@\n", errorMessage, errorStack);
    } withName:@"OnError"];
    
    
    // Second native method for JS side
    [JXcore addNativeBlock:^(NSArray *params, NSString *callbackId) {
        if (params == nil || [params count] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No IPv4?"
                                                            message:@"Better connect to Wifi to test this application"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        NSString* ipaddress = [params objectAtIndex:0];
        NSString* ipaddress2 =  nil;
        
        if ([params count] > 2)
        ipaddress2 = [params objectAtIndex:1];
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            [[self lblURL] setText:[NSString stringWithFormat:@"http://%@:3000/", ipaddress]];
//            
//            if (ipaddress2 != nil)
//            [[self lblURL2] setText:[NSString stringWithFormat:@"http://%@:3000/", ipaddress2]];
        });
    } withName:@"SetIPAddress"];
    
//    NSArray *params = [NSArray arrayWithObjects:@"app.js", nil];
    NSArray *params = [NSArray arrayWithObjects:@"server.js", nil];
    [JXcore callEventCallback:@"StartApplication" withParams:params];
     */
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)setDataList:(NSMutableArray *)data
{
    itemList = data;
    [_mainTableView reloadData];
}


#pragma mark UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cid = @"PPItemCell";
    PPItemCell *cell = (PPItemCell *)[tableView dequeueReusableCellWithIdentifier:cid];
    if (!cell) {
        cell = (PPItemCell *)([[NSBundle mainBundle] loadNibNamed:@"PPItemCell" owner:nil options:NULL][0]);
    }
    [cell setItem:itemList[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"PPItemCell" cacheByIndexPath:indexPath configuration:^(PPItemCell *cell) {
        // 配置 cell 的数据源，和 "cellForRow" 干的事一致，比如：
        [cell setItem:itemList[indexPath.row]];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIStoryboard *storyboard=self.storyboard;
    
    PPDetailViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"PPDetailViewController"];
    detail.href = ((PPMediaItem *)itemList[indexPath.row]).href;
    detail.titleString = ((PPMediaItem *)itemList[indexPath.row]).name;
    detail.cdate = ((PPMediaItem *)itemList[indexPath.row]).cdate;
    detail.hotString = ((PPMediaItem *)itemList[indexPath.row]).hot;
    detail.sizeString = ((PPMediaItem *)itemList[indexPath.row]).size;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *keyword = searchBar.text;
    if (keyword.length == 0){
        return;
    }
    [PPDispatch dataBy:keyword page:@"1" handle:^(id data, BOOL finish) {
        if (finish) {
            [self setDataList:(NSMutableArray *)data];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
