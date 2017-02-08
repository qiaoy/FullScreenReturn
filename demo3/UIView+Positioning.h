//
//  UIView+Positioning.h
//  demo3
//
//  Created by 乔岩 on 2017/2/8.
//  Copyright © 2017年 qiaoyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Positioning)

/** View's Y Position */
@property (nonatomic, assign) CGFloat   topY;

/** View's X Position */
@property (nonatomic, assign) CGFloat   leftX;

/** Y vale representing the bottom of the view **/
@property (nonatomic, assign) CGFloat   bottomY;

/** X Value representing the right side of the view **/
@property (nonatomic, assign) CGFloat   rightX;

/** View's width */
@property (nonatomic, assign) CGFloat   width;

/** View's height */
@property (nonatomic, assign) CGFloat   height;

/** X value of the object's center **/
@property (nonatomic, assign) CGFloat   centerX;

/** Y value of the object's center **/
@property (nonatomic, assign) CGFloat   centerY;

/** View's origin - Sets X and Y Positions */
@property (nonatomic, assign) CGPoint   origin;

/** View's size - Sets Width and Height */
@property (nonatomic, assign) CGSize    size;

/** Returns the Subview with the heighest X value **/
@property (nonatomic, strong, readonly) UIView *subviewOnHeighestX;

/** Returns the Subview with the heighest Y value **/
@property (nonatomic, strong, readonly) UIView *subviewOnHeighestY;

@end
