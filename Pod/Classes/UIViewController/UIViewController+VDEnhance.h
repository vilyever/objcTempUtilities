//
//  UIViewController+VDEnhance.h
//  objcTempUtilities
//
//  Created by Deng on 16/6/15.
//  Copyright © Deng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (VDEnhance)

#pragma mark Public Method
/**
 *  通过nib初始化VC
 *  @note 使用此方法 xib文件名和VC文件名必须相同
 *
 *  @return 初始化VC
 */
+ (instancetype)vd_controllerFromNib;

/**
 *  通过nib初始化VC
 *
 *  @param nibName xib文件名
 *
 *  @return 初始化VC
 */
+ (instancetype)vd_controllerFromNibWithNibName:(NSString *)nibName;

/**
 *  通过storyboard初始化VC
 *  @note 使用此方法 storyboard文件名必须为默认的Main.storyboard
 *  @note 使用此方法 VC对应的storyboard ID 必须与VC文件名相同
 *
 *  @return 初始化VC
 */
+ (instancetype)vd_controllerFromStoryboard;

/**
 *  通过storyboard初始化VC
 *  @note 使用此方法 VC对应的storyboard ID 必须与VC文件名相同
 *
 *  @param storyboardName storyboard文件名
 *
 *  @return 初始化VC
 */
+ (instancetype)vd_controllerFromStoryboardWithStoryboardName:(NSString *)storyboardName;

/**
 *  通过storyboard初始化VC
 *
 *  @param storyboardName storyboard文件名
 *  @param identifier     storyboard ID
 *
 *  @return 初始化VC
 */
+ (instancetype)vd_controllerFromStoryboardWithStoryboardName:(NSString *)storyboardName withIdentifier:(NSString *)identifier;

+ (UIViewController*)vd_topViewController;

+ (void)vd_backToRootViewController;

// with direction, it must length larger than 52.0f to show completion arrow
- (UIPopoverPresentationController *)vd_popoverFromView:(UIView *)view atDirection:(UIPopoverArrowDirection)direction shouldDisplayArrow:(BOOL)shouldDisplayArrow fromViewController:(UIViewController *)controller;

- (UIPopoverPresentationController *)vd_popoverInCenterOfWindowFromViewController:(UIViewController *)controller;

- (void)vd_dismiss;
- (void)vd_dismissWithAnimation:(BOOL)animated;

@end
