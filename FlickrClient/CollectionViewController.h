//
//  CollectionViewController.h
//  FlickrClient
//
//  Created by nsn on 10/5/16.
//  Copyright © 2016 nex sn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain)NSMutableArray *txts;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionV;

@end
