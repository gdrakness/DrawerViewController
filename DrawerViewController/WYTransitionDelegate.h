//
//  WYTransitionDelegate.h
//  DrawerViewController
//
//  Created by Josscii on 16/4/23.
//  Copyright © 2016年 Josscii. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WYDismissDelegate <NSObject>

- (void)dismissDrawer;

@end

@interface WYTransitionDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIView *dimmingView;
@property (nonatomic, strong) id<WYDismissDelegate> delegate;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;

@end
