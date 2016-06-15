//
//  UICollectionViewCell+VDEnhance.m
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import "UICollectionViewCell+VDEnhance.h"

//#import <objc/runtime.h>


@implementation UICollectionViewCell (VDEnhance)

#pragma mark Public Method
+ (void)vd_registerNibByCollectionView:(UICollectionView *)collectionView
{
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass( [self class] ) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass( [self class] ) ];
}

+ (void)vd_registerClassByCollectionView:(UICollectionView *)collectionView
{
    [collectionView registerClass:self forCellWithReuseIdentifier:NSStringFromClass( [self class] ) ];
}

#pragma mark Private Method


@end
