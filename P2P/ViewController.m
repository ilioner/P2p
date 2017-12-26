//
//  ViewController.m
//  P2P
//
//  Created by Tywin on 2017/12/26.
//  Copyright © 2017年 Tywin. All rights reserved.
//

#import "ViewController.h"
#import "JXcore.h"

static void callback(NSArray *args, NSString *return_id) { }

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
