//
//  Content.m
//  FlickrClient
//
//  Created by nsn on 10/6/16.
//  Copyright © 2016 nex sn. All rights reserved.
//
#import "Content.h"

@implementation Content
@synthesize urlString, img, farm, iD, ownerID, secret, server, title;
@synthesize ownerName, comments;

-(void)buildImageUrl
{
    NSString *fileName = [[[iD stringByAppendingString:@"_"] stringByAppendingString:secret] stringByAppendingString:@"_q.jpg"];
    urlString = [[[[[[@"https://" stringByAppendingString:farm] stringByAppendingString:@"."] stringByAppendingString:@"staticflickr.com/"] stringByAppendingString:server] stringByAppendingString:@"/"] stringByAppendingString:fileName];
}

@end
