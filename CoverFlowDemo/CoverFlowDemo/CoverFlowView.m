//
//  CoverFlowView.m
//  CoverFlowDemo
//
//  Created by Ari on 16/10/15.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "CoverFlowView.h"
#import "CoverFlowViewCell.h"
#import "CoverFlowLayout.h"
#define kSeed 3
#define kCellCount 10
@interface CoverFlowView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic,weak) UICollectionView *coverFlowCollectionView;
@end
static NSString *const cellID = @"cellID";
@implementation CoverFlowView


- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //注册cell
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:bgImageView];
    bgImageView.image = [UIImage imageNamed:@"ic_evaluate_bg"];
    UICollectionView *coverFlowCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, self.bounds.size.width, self.bounds.size.height * 0.8) collectionViewLayout:[[CoverFlowLayout alloc] init]];
    coverFlowCollectionView.backgroundColor = [UIColor clearColor];
    self.coverFlowCollectionView = coverFlowCollectionView;
    coverFlowCollectionView.dataSource = self;
    coverFlowCollectionView.showsVerticalScrollIndicator = false;
    coverFlowCollectionView.showsHorizontalScrollIndicator = false;
    [self addSubview:coverFlowCollectionView];
    [coverFlowCollectionView registerNib:[UINib nibWithNibName:@"CoverFlowViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    //上来显示在中间
    [coverFlowCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:kCellCount inSection:0] atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:NO];
    
}

#pragma mark - 数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return kCellCount * kSeed;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CoverFlowViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    return cell;
    
}

@end
