//
//  CoverFlowLayout.m
//  CoverFlowDemo
//
//  Created by Ari on 16/10/15.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "CoverFlowLayout.h"

@implementation CoverFlowLayout
// 准备布局
- (void)prepareLayout
{
    [super prepareLayout];
    
    // 设置item大小
    CGSize itemSize = self.collectionView.bounds.size;
    self.itemSize = CGSizeMake(itemSize.width * 0.7, itemSize.height);
    
    // 横向滑动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 内边的间距
    CGFloat inset = (self.collectionView.bounds.size.width - self.itemSize.width) * .5;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

// 返回需要计算的layout参数
- (NSArray<UICollectionViewLayoutAttributes*>*)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    // 系统的参数数组
    NSArray* tempAttrs = [super layoutAttributesForElementsInRect:rect];
    
    // 创建一个深拷贝的数组
    NSMutableArray* attrs = [[NSMutableArray alloc] initWithArray:tempAttrs copyItems:YES];

    // 获取屏幕中心的位置
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * .5;
    //    NSLog(@"%f", centerX);
    
    // 修改布局的参数
    // TODO:
    for (int i = 0; i < attrs.count; i++) {
        // 获取layout参数
        UICollectionViewLayoutAttributes* attr = attrs[i];
        
        // 获取cell的中心
        CGFloat attrCenterX = attr.center.x;
        // 计算cell的中心 到 collectionView的中心
        CGFloat attrDis = attrCenterX - centerX;
        // 获取距离的绝对值
        CGFloat attrDisABS = ABS(attrDis);
        
        // 创建默认的矩阵
        CATransform3D transform = CATransform3DIdentity;
        
        // 距离为 0  缩放 1
        // 距离为 50  缩放 0.8
        
        // y = a * x + b
        // 1 = a * 0 + b;
        // 0.9 = a * 100 + b;
        // 0.1 = a * -100
        // a = .1 / -100
        // a = -0.001
        // b = 1
        
        // 根据距离 计算缩放的比例
        if (attrDisABS > 100) {
            attrDisABS = 100;
        }
        CGFloat scale = -0.001 * attrDisABS + 1;
        // 在空白的矩阵的基础上 让矩阵进行缩放
        transform = CATransform3DScale(transform, scale, scale, 1);
        //透明度
        /**
         y = a * x + b
         1 = a * 0 + b
         0.7 = a * 100 + b
         */
        attr.alpha = -0.003 * attrDisABS + 1;
        attr.transform3D = transform;
    }
    
    return attrs;
}

// 每次松手以后 期望的offset的点
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    
    // 获取 期望显示的区域
    CGRect proposedRect = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    // 根据期望显示的区域 可以获取 附近需要计算的cell的attr
    NSArray* proposedAttrs = [self layoutAttributesForElementsInRect:proposedRect];
    
    // 获取期望的contentOffsetX
    CGFloat proposedContentOffsetX = proposedContentOffset.x;
    
    // 屏幕的中心
    CGFloat centerX = proposedContentOffsetX + self.collectionView.bounds.size.width * .5;
    
    // 左侧的位置
    CGFloat leftX = centerX - (self.itemSize.width + self.minimumLineSpacing) * .5;
    
    // 右侧的位置
    CGFloat rightX = centerX + (self.itemSize.width + self.minimumLineSpacing) * .5;
    // 记录最近的cell在当前参数数组中的位置
    //    NSInteger index = 0;
    
    // 用来记录最小的距离 第一次的时候 是最大值
    //    CGFloat flag = CGFLOAT_MAX;
    
    // 记录距离(可能是正可能是负)
    CGFloat flagDis = 0;
    
    for (int i = 0; i < proposedAttrs.count; i++) {
        // 获取某一个cell
        UICollectionViewLayoutAttributes* attr = proposedAttrs[i];
        
        if (attr.center.x > leftX && attr.center.x < rightX) {
            flagDis = attr.center.x - centerX;
        }
    }
    return CGPointMake(proposedContentOffsetX + flagDis, 0);
}

// 让布局失效
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
@end
