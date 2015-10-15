//
//  NewsDataManager.m
//  News
//
//  Created by Harsha on 01/08/15.
//  Copyright (c) 2015 Harsha. All rights reserved.
//

#import "DataManager.h"
#import "HTTPConnection.h"
#import "Item.h"
@interface DataManager()<HTTPConnectionDelegate>{

}
@end

@implementation DataManager
-(id)init{
    self = [super init];
    if(self){
    }
    return self;
}

-(void)start{
    HTTPConnection *connection = [[HTTPConnection alloc]init];
    connection.delegate = self;
    [connection startConnectionWithURL:@"https://gist.githubusercontent.com/maclir/f715d78b49c3b4b3b77f/raw/8854ab2fe4cbe2a5919cea97d71b714ae5a4838d/items.json"];
}

#pragma mark HTTPConnectionDelegate methods

-(void)connectionDownloadedWithData:(NSMutableData *)data{
    NSString *string = [[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"Data from  server:%@",string);
    NSError *error = nil;
    NSArray *dataArrayFromServer = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingOptions)kNilOptions error:&error];

    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
        for (NSDictionary *dataDict in dataArrayFromServer) {
            Item *item = [[Item alloc]init];
            item.title = [dataDict objectForKey:@"title"];
            item.itemDescription = [dataDict objectForKey:@"description"];
            item.imageUrl = [dataDict objectForKey:@"image"];
            [dataArray addObject:item];
        }
    if(_delegate && [_delegate respondsToSelector:@selector(dataDownloaded:)])
        [_delegate dataDownloaded:dataArray];
}

-(void)connectionFailedWithError:(NSError *)error{
    
}
@end
