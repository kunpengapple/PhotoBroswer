//
//  MHPhotoModel.m
//  图片浏览器
//
//  Created by 宋鲲鹏 on 16/4/12.
//  Copyright © 2016年 hcl. All rights reserved.
//

#import "MHPhotoModel.h"
@implementation MHPhotoModel
+ (MHPhotoModel *)photoWithImage:(UIImage *)image {
    return [[MHPhotoModel alloc] initWithImage:image];
}
- (id)initWithImage:(UIImage *)image {
    if ((self = [super init])) {
        _image = image;
    }
    return self;
}

+ (MHPhotoModel *)photoWithURL:(NSURL *)url {
    return [[MHPhotoModel alloc] initWithURL:url];
}
- (id)initWithURL:(NSURL *)url {
    if ((self = [super init])) {
        _photoURL = [url copy];
    }
    return self;
}

+ (MHPhotoModel *)photoWithAsset:(PHAsset *)asset
{
  return   [[MHPhotoModel alloc] initWithhAsset:asset];
}
- (id)initWithhAsset:(PHAsset *)asset
{
    if ((self = [super init])) {
        _phoAsset   = [asset copy];
    }
    return self;
}
@end
