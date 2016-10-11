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

-(void)buildImageUrlFrom:(Content *)content
{
    NSString *fileName = [[[content.iD stringByAppendingString:@"_"] stringByAppendingString:content.secret] stringByAppendingString:@"_q.jpg"];
    urlString = [[[[[[@"https://" stringByAppendingString:content.farm] stringByAppendingString:@"."] stringByAppendingString:@"staticflickr.com/"] stringByAppendingString:content.server] stringByAppendingString:@"/"] stringByAppendingString:fileName];
}

@end
