//
//  NewsTableViewCell.m
//  News
//
//  Created by Harsha on 01/08/15.
//  Copyright (c) 2015 Harsha. All rights reserved.
//

#import "ItemTableViewCell.h"
#import "HTTPConnection.h"

@interface  ItemTableViewCell()<HTTPConnectionDelegate>{
    NSString *_savePath;
}
@end

@implementation ItemTableViewCell

- (void)awakeFromNib {
    // Initialization code
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    _savePath = [documentsDirectory stringByAppendingPathComponent:@"/Cache"];
    if([[NSFileManager defaultManager] fileExistsAtPath:_savePath] == NO)
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:_savePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadDataWithArticle:(Item *)item{
    _item = item;
    self.titleLabel.text = item.title;
    self.descLabel.text = item.itemDescription;
    if([[NSFileManager defaultManager]fileExistsAtPath:[NSString stringWithFormat:@"%@/%@.png",_savePath,_item.title]]){
        self.image.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",_savePath,_item.title]];
    }
    else{
        self.image.image = nil;
    HTTPConnection *connection = [[HTTPConnection alloc]init];
    connection.delegate = self;
    [connection startConnectionWithURL:item.imageUrl];
    }
}

#pragma mark HTTPConnectionDelegate methods
-(void)connectionDownloadedWithData:(NSMutableData *)data{
    if(![[NSFileManager defaultManager]fileExistsAtPath:[NSString stringWithFormat:@"%@/%@.png",_savePath,_item.title]]){
        [[NSFileManager defaultManager] createFileAtPath:[NSString stringWithFormat:@"%@/%@.png",_savePath,_item.title] contents:data attributes:nil];
    }
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",_savePath,_item.title]];
        self.image.image = image;
}

-(void)connectionFailedWithError:(NSError *)error{
    
}


@end
