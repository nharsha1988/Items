//
//  HTTPConnection.m
//  News
//
//  Created by Harsha on 01/08/15.
//  Copyright (c) 2015 Harsha. All rights reserved.
//

#import "HTTPConnection.h"

@interface HTTPConnection()<NSURLConnectionDataDelegate>{
    NSURLConnection *_connection;
    NSMutableData *_data;
    NSString *_urlStr;
}
@end

@implementation HTTPConnection
-(id)init{
    self = [super init];
    if(self){
        _data = [NSMutableData data];
    }
    return self;
}

-(void)startConnectionWithURL:(NSString *)url{
    _urlStr = url;
    _connection = [[NSURLConnection alloc]initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] delegate:self];
    [_connection start];
}

#pragma mark NSURLConnectionDataDelegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSLog(@"Response from server:%ld",(long)[httpResponse statusCode]);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Error:%@",[error description]);
    if(_delegate && [_delegate respondsToSelector:@selector(connectionFailedWithError:)])
        [_delegate connectionFailedWithError:error];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_data appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if(_delegate && [_delegate respondsToSelector:@selector(connectionDownloadedWithData:)])
        [_delegate connectionDownloadedWithData:_data];
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection{
    return YES;
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
            [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
    }
}

@end
