//
//  DetailViewController.m
//  FlickrClient
//
//  Created by nsn on 10/7/16.
//  Copyright © 2016 nex sn. All rights reserved.
//
#import "DetailViewController.h"
#import "Constants.h"
#import "ObjectiveFlickr.h"
#define MAX_HEIGHT 1000
@interface DetailViewController()<OFFlickrAPIRequestDelegate>
{
        OFFlickrAPIContext *flickrContext;
        OFFlickrAPIRequest *flickrRequest;
    __weak IBOutlet UILabel *ownerNameLabel;
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UIScrollView *commentScrollView;
}
@property (nonatomic, retain)UILabel *commentLabel;
@property (nonatomic, retain)UIWebView *commentWebView;

@end

@implementation DetailViewController
@synthesize content, commentLabel, commentWebView;

-(void)viewDidLoad
{
    [super viewDidLoad];
    flickrContext = [[OFFlickrAPIContext alloc] initWithAPIKey:API_KEY sharedSecret:SHARED_SECRET];
    flickrRequest = [[OFFlickrAPIRequest alloc] initWithAPIContext:flickrContext];
    [flickrRequest setDelegate:self];
    ownerNameLabel.textAlignment = NSTextAlignmentCenter;
    ownerNameLabel.numberOfLines = 2;
    ownerNameLabel.textColor = [UIColor whiteColor];
    
    commentScrollView.backgroundColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor blackColor];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary
{
    NSDictionary *person = [inResponseDictionary objectForKey:@"person"];
    NSDictionary *comments = [inResponseDictionary objectForKey:@"comments"];

    if(person)
    {
        ownerNameLabel.text = [[ownerNameLabel.text stringByAppendingString:@"\n"] stringByAppendingString:[[person objectForKey:@"username"]objectForKey:@"_text"]];
     [self getPhotoCommentsForPhtoID:content.iD];
    }
    else if (comments)
    {
        NSString *text = @"";
        for (NSDictionary *c in [comments objectForKey:@"comment"])
        {
            NSString *authorname = [c objectForKey:@"authorname"];
            NSString *comment = [c objectForKey:@"_text"];
            
            text = [[[[[text stringByAppendingString:@"\n"] stringByAppendingString:authorname] stringByAppendingString:@"\n"] stringByAppendingString:comment] stringByAppendingString:@"\n\n"];;
        }
        
        commentLabel = [[UILabel alloc]initWithFrame:commentScrollView.frame];
        commentLabel.numberOfLines = MAX_HEIGHT;
        CGFloat width = commentLabel.frame.size.width;;
        UIFont *font = commentLabel.font;
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: font}];
         
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, MAX_HEIGHT}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        
        commentLabel.frame = rect;
        commentScrollView.contentSize = rect.size;
        commentLabel.text = text;
        commentLabel.textColor = [UIColor whiteColor];
        commentLabel.backgroundColor = [UIColor blackColor];
        [commentScrollView addSubview:commentLabel];
        
        
        commentWebView = [[UIWebView alloc]initWithFrame:commentScrollView.frame];

        
        
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

-(void)getPhotoCommentsForPhtoID:(NSString *)phtoID
{
    if (![flickrRequest isRunning])
    {
        [flickrRequest callAPIMethodWithGET:@"flickr.photos.comments.getList" arguments:[NSDictionary dictionaryWithObjectsAndKeys:phtoID,@"photo_id", nil]];
    }
}
@end
