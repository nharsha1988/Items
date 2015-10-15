//
//  NewsTableViewCell.h
//  News
//
//  Created by Harsha on 01/08/15.
//  Copyright (c) 2015 Harsha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
@interface ItemTableViewCell : UITableViewCell
@property(nonatomic,weak) IBOutlet UILabel *titleLabel;
@property(nonatomic,weak) IBOutlet UILabel *descLabel;
@property(nonatomic,weak) IBOutlet UIImageView *image;
@property(nonatomic,strong) Item *item;
-(void)loadDataWithArticle:(Item *)item;
@end
