//
//  PPPageParse.m
//  P2P
//
//  Created by Tywin on 2017/12/26.
//  Copyright © 2017年 Tywin. All rights reserved.
//

#import "PPPageParse.h"
#import <Ono/Ono.h>
#import "PPMediaItem.h"
#import "PPDetailMediaItem.h"

@implementation PPPageParse

+(id)parse:(NSString *)pageString handle:(parsehandle)handle
{
    NSData *data = [pageString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSMutableArray *dataArray = [NSMutableArray array];
    ONOXMLDocument *document = [ONOXMLDocument XMLDocumentWithData:data error:&error];
    
    NSString * olPath = @"//ul[@class='media-list media-list-set']";
    
    ONOXMLElement * olELement = [document firstChildWithXPath:olPath];
    NSInteger ecount = olELement.children.count;

    
    
    // Support for XPath & CSS Queries  /html/body/div[1]/div[4]/div/div[2]/div[1]
    [document enumerateElementsWithXPath:@"//div[@class='media-body']" usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
        ////ul[@class='media-list media-list-set']/li[1]/div/h4/a
        NSString *titlePath = [NSString stringWithFormat:@"//ul[@class='media-list media-list-set']/li[%ld]/div/h4/a",idx+1];
        ONOXMLElement *title =  [element firstChildWithXPath:titlePath];
        NSString *titleValue = title.stringValue;
        NSString *hrefvalue = title.attributes[@"href"];
        NSLog(@"hrefvalue %@",hrefvalue);
        
        ///html/body/div[1]/div[2]/div[3]/ul/li[2]/div/div/span[1]
        NSString *datePath = [NSString stringWithFormat:@"//ul[@class='media-list media-list-set']/li[%ld]/div/div/span[@class='label label-success']",idx+1];
        ONOXMLElement *dateNode =  [element firstChildWithXPath:datePath];
        NSString *datevalue = dateNode.stringValue;
        NSLog(@"dateNode %@",datevalue);
        
        NSString *sizePath = [NSString stringWithFormat:@"//ul[@class='media-list media-list-set']/li[%ld]/div/div/span[@class='label label-warning']",idx+1];
        ONOXMLElement *sizeNode =  [element firstChildWithXPath:sizePath];
        NSString *sizevalue = sizeNode.stringValue;
        NSLog(@"sizeNode %@",sizevalue);
        
        NSString *hotPath = [NSString stringWithFormat:@"//ul[@class='media-list media-list-set']/li[%ld]/div/div/span[@class='label label-primary']",idx+1];
        ONOXMLElement *hotNode =  [element firstChildWithXPath:hotPath];
        NSString *hotvalue = hotNode.stringValue;
        NSLog(@"hotNode %@",hotvalue);
        
        PPMediaItem *item = [[PPMediaItem alloc] init];
        item.name = titleValue;
        item.href = hrefvalue;
        item.cdate = datevalue;
        item.size = sizevalue;
        item.hot = hotvalue;
        [dataArray addObject:item];
        
        if (idx == ecount - 1) {
            NSLog(@"解析完成---");
            NSLog(@"dataarray---->%@",dataArray);
            handle(dataArray,YES);
        }
        
    }];
    
    return nil;
}

+(id)parseDetail:(NSString *)pageString handle:(parsehandle)handle
{
    
    PPDetailMediaItem *detailItem = [PPDetailMediaItem new];
    
    NSData *data = [pageString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    ONOXMLDocument *document = [ONOXMLDocument XMLDocumentWithData:data error:&error];
    
    NSString *magentPath = @"//*[@id='magnetLink']";
    ONOXMLElement * magentELement = [document firstChildWithXPath:magentPath];
    NSString *magentString = magentELement.stringValue;
    
    detailItem.magent = magentString;
    handle(detailItem,YES);
    
    return nil;
}

@end
