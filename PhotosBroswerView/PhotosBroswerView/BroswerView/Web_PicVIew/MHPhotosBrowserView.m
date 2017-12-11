//
//  MHPhotosBrowserView.h
//  图片浏览器
//
//  Created by LMH on 16/3/10.
//  Copyright © 2016年 LMH. All rights reserved.
//

#import "MHPhotosBrowserView.h"
#import "MHPhontoNewCollectionView.h"
//#import "MHPhotoCollectionCell.h"
#import "ZLPhotoTool.h"
@interface MHPhotosBrowserView()
{
    CGRect frameRect;
    NSMutableArray *photoArray;
    int totalItemsCount;
}

@property (assign, nonatomic) int currentIndex;
@property (nonatomic)int tempIndex;
@property (nonatomic,strong)    UICollectionView *photoCollectionView;
@end
@implementation MHPhotosBrowserView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        frameRect = frame;
        totalItemsCount = 0;
        photoArray = [[NSMutableArray alloc] init];
        [self addSubview:self.photoCollectionView];
       
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame Photos:(NSMutableArray*)array {
    self = [self initWithFrame:frame];
    if (self) {
        [self reloadPhotoBrowseWithPhotoArray:array];
    }
    return self;
}

- (void)reloadPhotoBrowseWithPhotoArray:(NSMutableArray *)array {
    [photoArray removeAllObjects];
    
    for (id imageUrl in array) {
        if ([imageUrl isKindOfClass:[NSString class]]) {
            MHPhotoModel *model =[MHPhotoModel photoWithURL:[NSURL URLWithString:imageUrl]];
            [photoArray addObject:model];
            
        }else if ([imageUrl isKindOfClass:[UIImage class]]){
            MHPhotoModel *model =[MHPhotoModel photoWithImage:imageUrl];
            [photoArray addObject:model];
        }else if ([imageUrl isKindOfClass:[MHPhotoModel class]]){
            [photoArray addObject:imageUrl];
        }
    }
    
//    [photoArray addObjectsFromArray:array];
    totalItemsCount = (int)photoArray.count;
     [self.photoCollectionView reloadData];
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    if (self.photoCollectionView.contentOffset.x == 0) {
        int targetIndex = 0;
        targetIndex = 0;
        targetIndex += self.currentImgIndex;
        if (totalItemsCount > 1) {
            [self.photoCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.photoCollectionView == scrollView) {
        CGFloat pageWidth = scrollView.frame.size.width;
        int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        int indexOnPageControl = (currentPage % (int)photoArray.count)+1;
        int sumPage = (int)photoArray.count;
        _currentIndex = indexOnPageControl - 1;
           if (self.delegate &&[self.delegate respondsToSelector:@selector(currentStringAboutIndex:currentIndex:)]) {
        [self.delegate currentStringAboutIndex:[NSString stringWithFormat:@"%d/%d",indexOnPageControl,sumPage] currentIndex:indexOnPageControl];
    }
//        if (lastPage == sumPage-1) {
//                   [MBProgressHUD showMessage:@"这已经是最后一页了"];
//        }
        
    }
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return totalItemsCount;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return frameRect.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MHPhontoNewCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCollectionViewCellIndex" forIndexPath:indexPath];
    __weak __typeof(self)weakSelf = self;
    cell.singleTapCallBack = ^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(photosBrowse:asingleTapSelectItemAtIndex:)]) {
            [weakSelf.delegate photosBrowse:weakSelf asingleTapSelectItemAtIndex:indexPath.item];
        }
    };
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    int itemIndex = indexPath.item % (int)photoArray.count;
    MHPhontoNewCollectionView *dddcell  =(MHPhontoNewCollectionView *)cell;
    MHPhotoModel *photo = nil;
    photo = [photoArray objectAtIndex:itemIndex];
    [dddcell reloadCellWith:photo isSynchronous:NO];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    int row = indexPath.item % (int)photoArray.count;
//    if (self.delegate && [self.delegate respondsToSelector:@selector(photosBrowse:didSelectItemAtIndex:)]) {
//        [self.delegate photosBrowse:self didSelectItemAtIndex:row];
//    }
}

-(UICollectionView *)photoCollectionView{
    if (!_photoCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frameRect.size.width, frameRect.size.height) collectionViewLayout:layout];
        [_photoCollectionView setPagingEnabled:YES];
        [_photoCollectionView setDelegate:self];
        [_photoCollectionView setDataSource:self];
        [_photoCollectionView setShowsHorizontalScrollIndicator:NO];
        [_photoCollectionView setBackgroundColor:[UIColor blackColor]];
        _photoCollectionView.alwaysBounceHorizontal = YES;
        [_photoCollectionView registerClass:[MHPhontoNewCollectionView class] forCellWithReuseIdentifier:@"photoCollectionViewCellIndex"];
        
    }
    return _photoCollectionView;
}

- (void)dealloc{    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
