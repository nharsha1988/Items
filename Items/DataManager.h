//
//  NewsDataManager.h
//  News
//
//  Created by Harsha on 01/08/15.
//  Copyright (c) 2015 Harsha. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DataManagerDelegate <NSObject>

-(void)dataDownloaded:(NSMutableArray *)dataArray;

@end


@interface DataManager : NSObject
-(void)start;
@property(nonatomic,weak) id<DataManagerDelegate> delegate;
@end
