//
//  CoverFlowViewCell.m
//  CoverFlowDemo
//
//  Created by Ari on 16/10/15.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "CoverFlowViewCell.h"

@implementation CoverFlowViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)drawRect:(CGRect)rect {
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:rect];
    [[UIColor whiteColor] setStroke];
    rectPath.lineWidth = 2;
    [rectPath stroke];
}
@end
