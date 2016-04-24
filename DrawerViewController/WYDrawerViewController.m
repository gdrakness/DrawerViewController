//
//  WYDrawerViewController.m
//  DrawerViewController
//
//  Created by Josscii on 16/4/23.
//  Copyright © 2016年 Josscii. All rights reserved.
//

#import "WYDrawerViewController.h"
#import "WYSelectCell.h"

@interface WYDrawerViewController () <UITableViewDelegate, UITableViewDataSource>

/*注意，被 present 的 viewController 最好不要添加一个与self.view等bounds的直接 subview，否则会导致后面的 view size改变后，这个 subview size 没有改变
@property (nonatomic, strong) UITableView *tableView; */

@end

@implementation WYDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

- (void)configureTableView {
    self.tableView.tableFooterView = [UIView new];
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.rowHeight = 48;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[WYSelectCell class] forCellReuseIdentifier:@"WYSelectCell"];
}

#pragma mark - tableview delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WYSelectCell" forIndexPath:indexPath];
    
    NSDictionary *item = self.items[indexPath.row];
    
    cell.titleLabel.text = item[@"title"];
    cell.accessoryImageView.image = item[@"image"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selectedItem == indexPath.row) {
        cell.selected = YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:(1-indexPath.row) inSection:0]].selected = NO;
    [self.delegate selectItem:indexPath.row];
}

@end
