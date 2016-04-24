//
//  WYDrawerViewController.h
//  DrawerViewController
//
//  Created by Josscii on 16/4/23.
//  Copyright © 2016年 Josscii. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WYSelectDelegate <NSObject>

- (void)selectItem:(NSInteger)index;
 
@end

@interface WYDrawerViewController : UITableViewController

/**
 *  item in items must be a dictionary, contains two key-value pairs
 *  the first key is `title`, value is a string 
 *  the second key is `image`, value is the name of the image
 */

@property (nonatomic, strong) NSArray *items;
@property (nonatomic) NSUInteger selectedItem;
@property (nonatomic, strong)id<WYSelectDelegate> delegate;

@end
