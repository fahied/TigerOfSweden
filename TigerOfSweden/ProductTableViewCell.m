//
//  ProductTableViewCell.m
//  TigerOfSweden
//
//  Created by Muhammad Fahied on 12/06/14.
//  Copyright (c) 2014 Muhammad Fahied. All rights reserved.
//

#import "ProductTableViewCell.h"
#import <QuartzCore/QuartzCore.h>


@implementation ProductTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.contentView.layer.borderWidth = 1;
        self.contentView.layer.cornerRadius = 5;
        self.contentView.clipsToBounds = YES;
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
