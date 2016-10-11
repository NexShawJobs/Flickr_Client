//
//  CollectionViewController.h
//  FlickrClient
//
//  Created by nsn on 10/5/16.
//  Copyright © 2016 nex sn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectiveFlickr.h"

@interface CollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, OFFlickrAPIRequestDelegate>
{
    OFFlickrAPIContext *flickrContext;
    OFFlickrAPIRequest *flickrRequest;
}
@property (nonatomic, retain)NSMutableArray *txts;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionV;

@end
