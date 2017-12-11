//
//  MHPhotoModel.h
//  图片浏览器
//
//  Created by 宋鲲鹏 on 16/4/12.
//  Copyright © 2016年 hcl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>


@interface MHPhotoModel : NSObject

@property (nonatomic,strong) NSString *caption;
@property (nonatomic,strong) NSURL *photoURL;
@property (nonatomic,readonly)PHAsset *phoAsset;
@property (nonatomic,readonly) UIImage *image;

@property (nonatomic)NSInteger addIndex;
@property (nonatomic)BOOL isSelected;

@property (nonatomic)CGFloat progressValue;
+ (MHPhotoModel *)photoWithImage:(UIImage *)image;
- (id)initWithImage:(UIImage *)image;

+ (MHPhotoModel *)photoWithURL:(NSURL *)url;
- (id)initWithURL:(NSURL *)url;

+ (MHPhotoModel *)photoWithAsset:(PHAsset *)asset;
- (id)initWithhAsset:(PHAsset *)asset;

@end
