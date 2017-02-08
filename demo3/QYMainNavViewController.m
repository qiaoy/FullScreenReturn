//
//  QYMainNavViewController.m
//  demo3
//
//  Created by 乔岩 on 2017/2/7.
//  Copyright © 2017年 qiaoyan. All rights reserved.
//

#import "QYMainNavViewController.h"
#import "UIView+Positioning.h"

@interface QYMainNavViewController () <UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) NSMutableArray <UIImage *>*screenCaptureList;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIImageView *screenCaptureImageView;
@property (nonatomic, strong) UIView *blackMaskView;
@property (nonatomic, assign) CGPoint startTouchPoint;

@end

static const CGFloat moveWidth = 60.f;
static const NSTimeInterval animateDuration = 0.3f;

@implementation QYMainNavViewController


- (id)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        self.isCanDragBack = YES;
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    self.screenCaptureList = [NSMutableArray array];
    [self addPanGestureRecognizer];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIImage *image = [self currentScreenCaptureImage];
    if (image) {
        [self.screenCaptureList addObject:image];
    }
    [super pushViewController:viewController animated:animated];
    
    [self resetPanGestureEnableStatus];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    [self.screenCaptureList removeLastObject];
    UIViewController *VC = [super popViewControllerAnimated:animated];
    if ([VC isKindOfClass:[self.topViewController class]]) {
        [self.screenCaptureList removeAllObjects];
    }
    [self resetPanGestureEnableStatus];
    return VC;
}


#pragma Private Method

- (void)addPanGestureRecognizer {
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerAction:)];
    self.panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.panGestureRecognizer];
}

- (UIImage *)currentScreenCaptureImage {
    UIView *view = self.view.superview;
    if (self.tabBarController) {
        view = self.tabBarController.view;
    }
    if (!view || CGRectIsEmpty(view.frame)) {
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
//    [view drawViewHierarchyInRect:view.frame afterScreenUpdates:NO];
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
        [subView drawViewHierarchyInRect:subView.frame afterScreenUpdates:NO];
    }];
    UIImage *screenCaptureImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenCaptureImage;
}

- (void)resetPanGestureEnableStatus {
    self.panGestureRecognizer.enabled = self.viewControllers.count > 1 ?: NO;
}

- (void)moveViewWithDisplacement:(CGFloat)displacement {
    CGFloat width = self.view.width;
    displacement = displacement <= width ? displacement : 0;
    displacement = displacement > 0 ? displacement : 0;
    self.view.leftX = displacement;
    
    CGFloat scale = displacement / (width * 20) + 0.95f;
    CGFloat alpha = 0.4f - displacement / 800;
    
    self.screenCaptureImageView.transform = CGAffineTransformMakeScale(scale, scale);
    self.blackMaskView.alpha = alpha;
}

#pragma mark - Action

- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint touchPoint = [panGestureRecognizer locationInView:[[UIApplication sharedApplication] keyWindow]];
    
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            self.startTouchPoint = touchPoint;
            self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
            [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
            [self.backgroundView addSubview:self.blackMaskView];
            
            self.screenCaptureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
            UIImage *lastScreenCaptureImage = [self.screenCaptureList lastObject];
            [self.screenCaptureImageView setImage:lastScreenCaptureImage];
            
            self.blackMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
            [self.backgroundView insertSubview:self.screenCaptureImageView belowSubview:self.blackMaskView];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            CGFloat displacement = touchPoint.x - self.startTouchPoint.x;
            [self moveViewWithDisplacement:displacement > 0 ? displacement : 0];
        }
            break;
        case UIGestureRecognizerStateEnded: {
            CGFloat displacement = touchPoint.x - self.startTouchPoint.x;
            if (displacement > moveWidth) {
                [UIView animateWithDuration:animateDuration animations:^{
                    [self moveViewWithDisplacement:[UIScreen mainScreen].bounds.size.width];
                } completion:^(BOOL finished) {
                    [self popViewControllerAnimated:NO];
                    self.view.leftX = 0;
                    self.backgroundView.hidden = YES;
                }];
            } else {
                [UIView animateWithDuration:animateDuration animations:^{
                    [self moveViewWithDisplacement:0];
                } completion:^(BOOL finished) {
                    self.backgroundView.hidden = YES;
                }];
            }
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStatePossible:
        {
            [UIView animateWithDuration:animateDuration animations:^{
                 [self moveViewWithDisplacement:0];
             } completion:^(BOOL finished) {
                 self.backgroundView.hidden = YES;
             }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.viewControllers count] <= 1 || !self.isCanDragBack) {
        return NO;
    }
    CGPoint velocity = [(UIPanGestureRecognizer *) gestureRecognizer velocityInView:[[UIApplication sharedApplication] keyWindow]];
    return !(velocity.x < 0 || ABS(velocity.x) < ABS(velocity.y)) ?: NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.isCanDragBack = NO;
    self.view.userInteractionEnabled = NO;
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.isCanDragBack = YES;
    self.view.userInteractionEnabled = YES;
}

#pragma mark - Gets

//- (UIView *)backgroundView {
//    if (!_backgroundView) {
//        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
//    }
//    return _backgroundView;
//}
//
//- (UIImageView *)screenCaptureImageView {
//    if (!_screenCaptureImageView) {
//        _screenCaptureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
//    }
//    return _screenCaptureImageView;
//}
//
//- (UIView *)blackMaskView {
//    if (!_blackMaskView) {
//        _blackMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
//        _blackMaskView.backgroundColor = [UIColor blackColor];
//    }
//    return _blackMaskView;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
