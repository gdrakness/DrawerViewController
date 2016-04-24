//
//  FirstViewController.m
//  DrawerViewController
//
//  Created by Josscii on 16/3/3.
//  Copyright © 2016年 Josscii. All rights reserved.
//

#import "FirstViewController.h"
#import "WYTabBarController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController


- (IBAction)didTap:(id)sender {
    WYTabBarController *tabBarController = (WYTabBarController *)self.tabBarController;
    [tabBarController toggleDrawer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
