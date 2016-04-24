//
//  WYTransitionDelegate.m
//  DrawerViewController
//
//  Created by Josscii on 16/4/23.
//  Copyright © 2016年 Josscii. All rights reserved.
//

#import "WYTransitionDelegate.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define INITIAL_WIDTH (SCREEN_WIDTH * 0.8f)
#define INITIAL_FRAME CGRectMake(-INITIAL_WIDTH, 0, INITIAL_WIDTH, SCREEN_HEIGHT)
#define FINAL_FRAME CGRectMake(0, 0, INITIAL_WIDTH, SCREEN_HEIGHT)

@interface WYTransitionDelegate () <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isPresenting;

@end

@implementation WYTransitionDelegate

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;
    
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    if (self.isPresenting) {
        /*setup the initial state*/
        toView.frame = INITIAL_FRAME;
        
        self.dimmingView = [[UIView alloc] initWithFrame:containerView.bounds];
        self.dimmingView.backgroundColor = [UIColor blackColor];
        self.dimmingView.alpha = 0;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self.delegate action:@selector(dismissDrawer)];
        gesture.numberOfTapsRequired = 1;
        [self.dimmingView addGestureRecognizer:gesture];
        
        /*add toview and the dimming view to container*/
        [containerView addSubview:self.dimmingView];
        [containerView addSubview:toView];
        
        /*animation*/
        
        [UIView animateWithDuration:transitionDuration animations:^{
            self.dimmingView.alpha = 0.5;
            toView.frame = FINAL_FRAME;
        } completion:^(BOOL finished) {
            /*有手势操作后必须这样写*/
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext completeTransition:NO];
            } else {
                [transitionContext completeTransition:YES];
            }
        }];
    } else {
        [UIView animateWithDuration:transitionDuration animations:^{
            self.dimmingView.alpha = 0;
            fromView.frame = INITIAL_FRAME;
        } completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext completeTransition:NO];
            } else {
                [transitionContext completeTransition:YES];
                [self.dimmingView removeFromSuperview];
            }
        }];
    }
}


#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresenting = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresenting = NO;
    return self;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    self.isPresenting = YES;
    return self.percentDrivenInteractiveTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    self.isPresenting = NO;
    return self.percentDrivenInteractiveTransition;
}

@end
