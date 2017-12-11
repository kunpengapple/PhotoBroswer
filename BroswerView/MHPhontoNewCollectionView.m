//
//  MHPhontoNewCollectionView.m
//  Kacha
//
//  Created by 宋鲲鹏 on 16/7/7.
//  Copyright © 2016年 fengniao. All rights reserved.
//

#import "MHPhontoNewCollectionView.h"
#import "UIImageView+WebCache.h"
#import "ZLDefine.h"
#import "ZLPhotoTool.h"
#import "MBProgressHUD.h"
//#import "MBProgressHUD+SKP.h"

@interface MHPhontoNewCollectionView()
@property (nonatomic,strong)    MBProgressHUD *progressView;
@end
@implementation MHPhontoNewCollectionView
- (void)reloadCellWith:(MHPhotoModel*)photo{
    [self reloadCellWith:photo isSynchronous:YES];
}
- (void)reloadCellWith:(MHPhotoModel*)photo isSynchronous:(BOOL)isSynchronous{
    if (photo.image) {
        self.imageView.image =photo.image;
        [self resetSubviewSize];
    }
    else if(photo.photoURL){
       [self addSubview:self.progressView];
        UIImage *placeImage =[UIImage imageNamed:@"fengniao_place_logo"];
        __weak typeof(self) weakSelf = self;
        [self resetSubviewSize];
        //UIProgressView *progressView
        [self.imageView sd_setImageWithURL:photo.photoURL placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                MBRoundProgressView *roudView =[weakSelf.progressView  valueForKey:@"indicator"];
                roudView.progress =receivedSize/(expectedSize*1.0);
            });
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
             [weakSelf.progressView removeFromSuperview];
            if (image) {
                [weakSelf resetSubviewSize];
            }
            if (error) {
                self.imageView.image =placeImage;
                self.imageView.contentMode= UIViewContentModeScaleAspectFit;
                [weakSelf resetSubviewSize];
            }
        }];
    }
    else if (photo.phoAsset){
        CGFloat scale = [UIScreen mainScreen].scale;
        CGFloat width = MIN(kViewWidth, kMaxImageWidth);
        CGSize size = CGSizeMake(width*scale, width*scale*photo.phoAsset.pixelHeight/photo.phoAsset.pixelWidth);
        NSLog(@" NSStringFromCGSize%@",NSStringFromCGSize(size));
        [[ZLPhotoTool sharePhotoTool] requestImageForAsset:photo.phoAsset isSynchronous:YES size:size resizeMode:PHImageRequestOptionsResizeModeNone completion:^(UIImage *image) {
            self.imageView.image = image;
            [self resetSubviewSize];
        }];
        
    }
}
-(MBProgressHUD *)progressView
{
    if (!_progressView) {
        _progressView =[[MBProgressHUD alloc] initWithView:self];
        _progressView.mode=MBProgressHUDModeAnnularDeterminate;
        _progressView.alpha = 0.8;
        _progressView.color = [UIColor clearColor];
        //      _progressView.backgroundColor =[UIColor clearColor];
        //        progressView..backgroundColor =[UIColor clearColor];
        //        progressView.bezelView.color =[UIColor  clearColor];
        MBRoundProgressView *roudView =[_progressView  valueForKey:@"indicator"];
        roudView.backgroundTintColor =[UIColor lightGrayColor];
        roudView.progressTintColor =[UIColor  whiteColor];
    }
    return _progressView;
}


@end
