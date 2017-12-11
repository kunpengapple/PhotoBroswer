//
//  MHPhontoNewCollectionView.h
//  Kacha
//
//  Created by 宋鲲鹏 on 16/7/7.
//  Copyright © 2016年 fengniao. All rights reserved.
//

#import "ZLBigImageCell.h"
#import "MHPhotoModel.h"

@interface MHPhontoNewCollectionView : ZLBigImageCell
- (void)reloadCellWith:(MHPhotoModel*)photo isSynchronous:(BOOL)isSynchronous;
- (void)reloadCellWith:(MHPhotoModel*)photo;

@end
