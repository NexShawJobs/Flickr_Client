//
//  CollectionViewController.m
//  FlickrClient
//
//  Created by nsn on 10/5/16.
//  Copyright © 2016 nex sn. All rights reserved.
//
#import "CollectionViewController.h"
#import "Constants.h"
#import "CustomCell.h"
#import "Content.h"
#import "CustomReusableView.h"
#import "DetailViewController.h"
@interface CollectionViewController()

@property (nonatomic, retain) NSMutableArray *contts;
@end

@implementation CollectionViewController
@synthesize contts;
@synthesize txts;
@synthesize collectionV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    contts = [NSMutableArray new];
    txts = [NSMutableArray new];
    collectionV.delegate = self;
    collectionV.dataSource = self;
    
    flickrContext = [[OFFlickrAPIContext alloc] initWithAPIKey:API_KEY sharedSecret:SHARED_SECRET];
    flickrRequest = [[OFFlickrAPIRequest alloc] initWithAPIContext:flickrContext];
    [flickrRequest setDelegate:self];
    
    if (![flickrRequest isRunning]) {
    [flickrRequest callAPIMethodWithGET:@"flickr.interestingness.getList" arguments:[NSDictionary dictionaryWithObjectsAndKeys:@"100", @"per_page", nil]];
    }
}

#pragma mark -
#pragma mark OFFlickrAPIRequestDelegate
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary
{
    NSDictionary *photos = [inResponseDictionary objectForKey:@"photos"];
    NSDictionary *person = [inResponseDictionary objectForKey:@"person"];
    NSDictionary *comments = [inResponseDictionary objectForKey:@"comments"];

    if(photos)
    {
        for (NSDictionary *photo in [photos objectForKey:@"photo"])
        {
            Content *cont = [Content new];
            cont.farm = [NSString stringWithFormat:@"farm%@",[photo objectForKey:@"farm"]];
            cont.iD = [NSString stringWithFormat:@"%@",[photo objectForKey:@"id"]];
            cont.ownerID = [photo objectForKey:@"owner"];
            cont.secret = [NSString stringWithFormat:@"%@", [photo objectForKey:@"secret"]];
            cont.server = [NSString stringWithFormat:@"%@", [photo objectForKey:@"server"]];
            cont.title = [NSString stringWithFormat:@"%@", [photo objectForKey:@"title"]];
            cont.comments = [[NSMutableArray alloc]init];
            [cont buildImageUrlFrom:cont];
            [contts addObject:cont];
            
            NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc] init];
            [request2 setURL:[NSURL URLWithString:cont.urlString]];
            [request2 setHTTPMethod:@"POST"];
            [request2 setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            
            NSURLSession *session2 = [NSURLSession sharedSession];
            NSURLSessionDataTask *dataTask2 = [session2 dataTaskWithRequest:request2
                                                          completionHandler:^(NSData *data2, NSURLResponse *response2, NSError *error2)
                                               {
                                                   //XCTAssertTrue(error2 == nil);

                                                   if (data2 != nil && error2 == nil)
                                                   {
                                                       UIImage *img =[UIImage imageWithData:data2];
                                                       if (img != nil)
                                                       {
                                                           NSString *imgUrl = [[response2 URL] absoluteString];
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               [collectionV reloadData];
                                                           });
                                                           
                                                           Content *ctTmp;
                                                           for (Content *ct in contts)
                                                           {
                                                               if([ct.urlString isEqualToString:imgUrl])
                                                               {
                                                                   ct.img = img;
                                                                   ctTmp = ct;
                                                                   break;
                                                               }
                                                           }
                                                       }
                                                   }
                                                   if(error2)
                                                   {
                                                       Content *ct = [Content new];
                                                       ct.title = @"No Image Found";
                                                   }
                                               }];
            [dataTask2 resume];
        }
    }
    else if(person)
    {
        for (Content *ct in contts)
        {
            if([ct.ownerID isEqualToString:[person objectForKey:@"id"]])
            {
                ct.ownerName = [[person objectForKey:@"username"] objectForKey:@"_text"];
                break;
            }
        }
    }
    else if (comments)
    {
        for(Content *ct  in contts)
        {
            if([ct.iD isEqualToString:[comments objectForKey:@"photo_id"]])
            {
                for(NSDictionary *c in [comments objectForKey:@"comment"])
                {
                    [ct.comments addObject:[c objectForKey:@"_text"]];
                }
            }
        }
    }
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didFailWithError:(NSError *)inError
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Network Issue"
                                          message:@"It looks like you don’t have an Internet Connection"
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                               }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -
#pragma mark Uicollectionviewdatasource
//required
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(contts.count > 0)
        return contts.count;
    return 0;
}

//required
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    CustomCell *cell = [collectionV dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (contts.count > indexPath.row)
    {
        cell.cellImageView.image = ((Content *)[contts objectAtIndex:indexPath.row]).img;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark -
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    DetailViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    [flickrRequest setDelegate:vc];
    [self getOwnerNameForID:((Content *)[contts objectAtIndex:indexPath.row]).ownerID];

    vc.content = [contts objectAtIndex:indexPath.row];
    [self showViewController:vc sender:nil];
}

-(UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        ((CustomReusableView *)headerView).reusableViewLabel.text = @"Flickr Interestingness";
        ((CustomReusableView *)headerView).reusableViewLabel.textColor = [UIColor whiteColor];

        return headerView;
    }
    return nil;
}

#pragma mark -
-(void)getOwnerNameForID:(NSString *)ownderID
{
    if (![flickrRequest isRunning])
    {
        [flickrRequest callAPIMethodWithGET:@"flickr.people.getInfo" arguments:[NSDictionary dictionaryWithObjectsAndKeys:ownderID,@"user_id", nil]];
    }
}

-(CGSize)imageSizeForImage:(UIImage *)image
{
    return image.size;
}
@end
