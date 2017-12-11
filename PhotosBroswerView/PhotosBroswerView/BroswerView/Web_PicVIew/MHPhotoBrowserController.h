//
//  MHPhotoBrowserController.h
//  图片浏览器
//
//使用例子
//MHPhotoBrowserController *vc = [MHPhotoBrowserController new];
//NSMutableArray * bigImgArray = [NSMutableArray new];
//
//[bigImgArray addObject:[MHPhotoModel photoWithURL:[NSURL URLWithString:@"http://preview.quanjing.com/chineseview005/1s-2248.jpg"]]];;
//[bigImgArray addObject:[MHPhotoModel photoWithURL:[NSURL URLWithString:@"http://img2.3lian.com/img2007/19/33/005.jpg"]]];
//[bigImgArray addObject:[MHPhotoModel photoWithURL:[NSURL URLWithString:@"http://pic41.nipic.com/20140522/14008425_123928499349_2.jpg"]]];
//[bigImgArray addObject:[MHPhotoModel photoWithURL:[NSURL URLWithString:@"http://pic2.nipic.com/20090505/225028_095418098_2.jpg"]]];
//vc.currentImgIndex =0;
//vc.imgArray = bigImgArray;
//UINavigationController *navc =[[UINavigationController alloc] initWithRootViewController:vc];
//[self presentViewController:navc animated:YES completion:nil];

//  Created by 宋鲲鹏 on 16/4/12.
//  Copyright © 2016年 hcl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MHPhotoBrowserPopOperation)(NSArray *,BOOL isPushVC);
@interface MHPhotoBrowserController :UIViewController

//显示当前页码 0 为第一页 1第二页
@property (nonatomic,assign)int currentImgIndex;

@property (nonatomic,copy) MHPhotoBrowserPopOperation popOperation;

@property (nonatomic,strong)NSMutableArray *imgArray;

@end
