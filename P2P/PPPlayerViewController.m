//
//  PPPlayerViewController.m
//  P2P
//
//  Created by Tywin on 2018/1/1.
//  Copyright © 2018年 Tywin. All rights reserved.
//

#import "PPPlayerViewController.h"
#import "TBPlayer.h"
@interface PPPlayerViewController ()

@end

@implementation PPPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[TBPlayer sharedInstance] playWithUrl:[NSURL URLWithString:_url] showView:self.view];
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
