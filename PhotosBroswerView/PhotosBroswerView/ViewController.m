//
//  ViewController.m
//  PhotosBroswerView
//
//  Created by 宋坤鹏 on 2017/12/6.
//  Copyright © 2017年 宋坤鹏. All rights reserved.
//

#import "ViewController.h"
#import "MHPhotoBrowserController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)nameAction:(id)sender {
    MHPhotoBrowserController *vc = [[MHPhotoBrowserController alloc] init];
    NSMutableArray * bigImgArray = [NSMutableArray new];
    
    [bigImgArray addObject:@"http://preview.quanjing.com/chineseview005/1s-2248.jpg"];;
    [bigImgArray addObject:@"http://img2.3lian.com/img2007/19/33/005.jpg"];
    [bigImgArray addObject:@"http://pic41.nipic.com/20140522/14008425_123928499349_2.jpg"];
    [bigImgArray addObject:@"http://pic2.nipic.com/20090505/225028_095418098_2.jpg"];
    [bigImgArray addObject:[UIImage imageNamed:@"宋坤鹏-Jim"]];
    vc.currentImgIndex =2;
    vc.imgArray = bigImgArray;
    UINavigationController *navc =[[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
