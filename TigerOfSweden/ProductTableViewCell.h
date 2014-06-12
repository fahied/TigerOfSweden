//
//  ProductTableViewCell.h
//  TigerOfSweden
//
//  Created by Muhammad Fahied on 12/06/14.
//  Copyright (c) 2014 Muhammad Fahied. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *largeImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end
