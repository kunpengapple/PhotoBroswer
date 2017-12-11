//
//  MHPhotosBrowserView.h
//  图片浏览器
//
//  Created by 宋鲲鹏 on 16/4/12.
//  Copyright © 2016年 hcl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MHPhotosBrowserView;
@protocol MHPhotosBrowseDelegate <NSObject>
@optional
- (void)photosBrowse:(MHPhotosBrowserView *)photosBrowse asingleTapSelectItemAtIndex:(NSInteger)index;
-(void)currentStringAboutIndex:(NSString *)currenStr currentIndex:(NSInteger)index;

@end

@interface MHPhotosBrowserView: UIView<UICollectionViewDataSource,UIScrollViewAccessibilityDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,assign)int currentImgIndex;    //移动到第几个图片 从1开始
@property (nonatomic, weak) id<MHPhotosBrowseDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;

- (id)initWithFrame:(CGRect)frame Photos:(NSMutableArray*)array;

- (void)reloadPhotoBrowseWithPhotoArray:(NSMutableArray*)array;

@end
