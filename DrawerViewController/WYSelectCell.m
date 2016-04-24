//
//  WYSelectCell.m
//  DrawerViewController
//
//  Created by Josscii on 16/4/23.
//  Copyright © 2016年 Josscii. All rights reserved.
//

#import "WYSelectCell.h"

@interface WYSelectCell ()

@property (nonatomic, strong) UIView *selectedBgView;

@end

@implementation WYSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectedBackgroundView = self.selectedBgView;
        [self configureLayout];
    }
    return self;
}

- (void)configureLayout {
    for (UIView *v in @[self.titleLabel, self.accessoryImageView]) {
        [v setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:v];
    }
    
    // add constraints
    [NSLayoutConstraint constraintWithItem:self.accessoryImageView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1
                                  constant:20].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.accessoryImageView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1
                                  constant:20].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.accessoryImageView
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1
                                  constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.accessoryImageView
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1
                                  constant:16].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.titleLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.accessoryImageView
                                 attribute:NSLayoutAttributeRight
                                multiplier:1
                                  constant:32].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.titleLabel
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1
                                  constant:0].active = YES;
}

#pragma mark -

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor colorWithRed:0.129f green:0.129f blue:0.129f alpha:1];
    }
    return _titleLabel;
}

- (UIImageView *)accessoryImageView {
    if (!_accessoryImageView) {
        _accessoryImageView = [[UIImageView alloc] init];
        _accessoryImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _accessoryImageView;
}

- (UIView *)selectedBgView {
    if (!_selectedBgView) {
        _selectedBgView = [[UIView alloc] init];
        _selectedBgView.backgroundColor = [UIColor colorWithRed:0.961f green:0.961f blue:0.961f alpha:1];
    }
    return _selectedBgView;
}

@end