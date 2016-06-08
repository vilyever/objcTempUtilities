//
//  UIViewController+VDEnhance.h
//  VDKit
//
//  Created by FTET on 15/1/28.
//  Copyright (c) 2015年 Vilyever. All rights reserved.
//

#import <UIKit/UIKit.h>


/* 视图显现方式 */
typedef NS_ENUM(NSInteger, VDViewControllerDisplayType) {
    VDViewControllerDisplayTypePresented, // Modal模态
    VDViewControllerDisplayTypePushed, // Navigation Push
    VDViewControllerDisplayTypeInTab, // 内嵌在UITabbar中
    VDViewControllerDisplayTypePopover  // 通过Popover方式弹出
};


@interface UIViewController (VDEnhance)


#pragma Methods
#pragma Public Class Method
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

+ (UIViewController*)vd_topViewControllerWithRootViewController:(UIViewController*)rootViewController;

+ (void)vd_backToRootViewController;

#pragma Public Instance Method
/**
 *  退出此VC
 *
 *  @param appearType VC的显现方式
 */
- (void)vd_dismissWithDisplayType:(VDViewControllerDisplayType)displayType;


// with direction, it must length larger than 52.0f to show completion arrow
- (UIPopoverPresentationController *)vd_popoverFromView:(UIView *)view atDirection:(UIPopoverArrowDirection)direction shouldDisplayArrow:(BOOL)shouldDisplayArrow fromViewController:(UIViewController *)controller;

- (UIPopoverPresentationController *)vd_popoverInCenterOfWindowFromViewController:(UIViewController *)controller;

- (void)vd_excuteActionAfterViewDidLoad:(void (^)(void) )block NS_DEPRECATED_IOS(5_0, 5_0, "Aspects can do this better");
- (void)vd_excuteActionWithTag:(NSString *)tag afterViewDidLoad:(void (^)(void) )block NS_DEPRECATED_IOS(5_0, 5_0, "Aspects can do this better");
- (void)vd_clearAllActionsAfterViewDidLoad NS_DEPRECATED_IOS(5_0, 5_0, "Aspects can do this better");

@end
