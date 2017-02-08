//
//  UIView+Positioning.m
//  demo3
//
//  Created by 乔岩 on 2017/2/8.
//  Copyright © 2017年 qiaoyan. All rights reserved.
//

#import "UIView+Positioning.h"

@implementation UIView (Positioning)

//@dynamic topY, leftX, width, height, origin, size;

#pragma mark - Setters

-(void)setTopY:(CGFloat)topY {
    CGRect r = self.frame;
    r.origin.y = topY;
    self.frame = r;
}

-(void)setLeftX:(CGFloat)leftX {
    CGRect r = self.frame;
    r.origin.x = leftX;
    self.frame = r;
}

-(void)setBottomY:(CGFloat)bottomY {
    CGRect frame = self.frame;
    frame.origin.y = bottomY - frame.size.height;
    self.frame = frame;
}

-(void)setRightX:(CGFloat)rightX {
    CGRect frame = self.frame;
    frame.origin.x = rightX - frame.size.width;
    self.frame = frame;
}

-(void)setWidth:(CGFloat)width{
    CGRect r = self.frame;
    r.size.width = width;
    self.frame = r;
}

-(void)setHeight:(CGFloat)height{
    CGRect r = self.frame;
    r.size.height = height;
    self.frame = r;
}

-(void)setOrigin:(CGPoint)origin{
    self.leftX = origin.x;
    self.topY = origin.y;
}

-(void)setSize:(CGSize)size{
    self.width = size.width;
    self.height = size.height;
}

-(void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

-(void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

#pragma mark - Getters

-(CGFloat)x{
    return self.frame.origin.x;
}

-(CGFloat)y{
    return self.frame.origin.y;
}

-(CGFloat)width{
    return self.frame.size.width;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(CGPoint)origin{
    return CGPointMake(self.x, self.y);
}

-(CGSize)size{
    return CGSizeMake(self.width, self.height);
}

-(CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat)centerX {
    return self.center.x;
}

-(CGFloat)centerY {
    return self.center.y;
}

-(UIView *)subviewOnHeighestX {
    if(self.subviews.count > 0){
        UIView *subView = self.subviews[0];
        
        for(UIView *view in self.subviews)
            if(view.x > subView.x)
                subView = view;
        
        return subView;
    }
    
    return nil;
}

-(UIView *)subviewOnHeighestY {
    if(self.subviews.count > 0){
        UIView *subView = self.subviews[0];
        
        for(UIView *view in self.subviews)
            if(view.y > subView.y)
                subView = view;
        
        return subView;
    }
    
    return nil;
}

@end
