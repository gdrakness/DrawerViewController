//
//  WYTabBarController.m
//  DrawerViewController
//
//  Created by Josscii on 16/4/23.
//  Copyright © 2016年 Josscii. All rights reserved.
//

#import "WYTabBarController.h"
#import "WYDrawerViewController.h"
#import "WYTransitionDelegate.h"

@interface WYTabBarController () <WYDismissDelegate, UIGestureRecognizerDelegate, WYSelectDelegate>

@property (nonatomic, strong) WYDrawerViewController *drawerController;
@property (nonatomic, strong) WYTransitionDelegate *transitionDelegate;

@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *leftEdgePanGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *rightEdgePanGesture;

@end

@implementation WYTabBarController


- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBar.hidden = YES;
        [self.view addGestureRecognizer:self.leftEdgePanGesture];
        
        self.drawerController.items = self.items;
        self.drawerController.selectedItem = self.selectedIndex;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.tabBar.hidden = YES;
        [self.view addGestureRecognizer:self.leftEdgePanGesture];
        
        if (self.items == nil) {
            NSMutableArray *tempItems = [NSMutableArray array];
            for (int i = 0; i < self.tabBar.items.count; i++) {
                NSDictionary *tempDic = @{@"title": self.tabBar.items[i].title,
                                          @"image": self.tabBar.items[i].image};
                [tempItems addObject:tempDic];
            }
            self.items = [tempItems copy];
        }
        
        self.drawerController.items = self.items;
    }
    return self;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gesture {
    CGPoint point = [gesture translationInView:gesture.view];
    CGFloat progress = ABS(point.x) / gesture.view.bounds.size.width;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.transitionDelegate.percentDrivenInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        
        if (gesture == self.leftEdgePanGesture && point.x >= 0) {
            [self toggleDrawer];
        } else if (gesture == self.panGesture && point.x < 0) {
            [self dismissDrawer];
        }
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        [self.transitionDelegate.percentDrivenInteractiveTransition updateInteractiveTransition:progress];
    }
    else if (gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateEnded) {
        //判断手势滑动距离是否超过屏幕的一半，如果超过一半则完成pop动画
        
        if (progress > 0.5) {
            [self.transitionDelegate.percentDrivenInteractiveTransition finishInteractiveTransition];
        }
        else{
            [self.transitionDelegate.percentDrivenInteractiveTransition cancelInteractiveTransition];
        }
        
        // 这里设置为 nil
        self.transitionDelegate.percentDrivenInteractiveTransition = nil;
    }
}

/*
 调试的时候出现的 Bug，手势滑动太快第一次无法识别
 */

- (void)toggleDrawer {
    self.drawerController.selectedItem = self.selectedIndex;
    [self presentViewController:self.drawerController animated:YES completion:nil];
}

- (void)dismissDrawer {
    [self.drawerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectItem:(NSInteger)index {
    [self setSelectedIndex:index];
    [self dismissDrawer];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - 

- (WYDrawerViewController *)drawerController {
    if (!_drawerController) {
        _drawerController = [[WYDrawerViewController alloc] init];
        /*设置被 present 的 viewController 的属性才可以哦*/
        _drawerController.transitioningDelegate = self.transitionDelegate;
        _drawerController.modalPresentationStyle = UIModalPresentationCustom;
        [_drawerController.view addGestureRecognizer:self.panGesture];
        [_drawerController.view addGestureRecognizer:self.rightEdgePanGesture];
        _drawerController.delegate = self;
    }
    return _drawerController;
}

- (UIPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    }
    return _panGesture;
}

- (UIScreenEdgePanGestureRecognizer *)leftEdgePanGesture {
    if (!_leftEdgePanGesture) {
        _leftEdgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        _leftEdgePanGesture.edges = UIRectEdgeLeft;
    }
    return _leftEdgePanGesture;
}

- (UIScreenEdgePanGestureRecognizer *)rightEdgePanGesture {
    if (!_rightEdgePanGesture) {
        _rightEdgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        _rightEdgePanGesture.edges = UIRectEdgeRight;
        _rightEdgePanGesture.delegate = self;
    }
    return _rightEdgePanGesture;
}

- (WYTransitionDelegate *)transitionDelegate {
    if (!_transitionDelegate) {
        _transitionDelegate = [[WYTransitionDelegate alloc] init];
        _transitionDelegate.delegate = self;
    }
    return _transitionDelegate;
}

@end
