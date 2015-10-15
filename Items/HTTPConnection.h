//
//  HTTPConnection.h
//  News
//
//  Created by Harsha on 01/08/15.
//  Copyright (c) 2015 Harsha. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTTPConnectionDelegate <NSObject>

-(void)connectionDownloadedWithData:(NSMutableData *)data;
-(void)connectionFailedWithError:(NSError *)error;
@end

@interface HTTPConnection : NSObject
-(void)startConnectionWithURL:(NSString *)url;
@property(nonatomic) id<HTTPConnectionDelegate> delegate;
@end
