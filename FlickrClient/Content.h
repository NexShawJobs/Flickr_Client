//
//  Content.h
//  FlickrClient
//
//  Created by nsn on 10/6/16.
//  Copyright © 2016 nex sn. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Content : NSObject

@property (nonatomic, retain)NSString *urlString;
@property (nonatomic, retain)UIImage *img;
@property (nonatomic, retain)NSString *farm;
@property (nonatomic, retain)NSString *iD;
@property (nonatomic, retain)NSString *ownerID;
@property (nonatomic, retain)NSString *secret;
@property (nonatomic, retain)NSString *server;
@property (nonatomic, retain)NSString *title;

@property (nonatomic, retain)NSString *ownerName;
@property (nonatomic, retain)NSMutableArray *comments;


-(void)buildImageUrlFrom:(Content *)content;

@end
