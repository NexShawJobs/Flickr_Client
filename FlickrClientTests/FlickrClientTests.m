//
//  FlickrClientTests.m
//  FlickrClientTests
//
//  Created by nsn on 10/5/16.
//  Copyright © 2016 nex sn. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CollectionViewController.h"
#import "DetailViewController.h"
#import "ObjectiveFlickr.h"
#import "Constants.h"

@interface FlickrClientTests : XCTestCase <OFFlickrAPIRequestDelegate>

@property (nonatomic) CollectionViewController *collectionViewControllerToTest;
@property (nonatomic) DetailViewController *detailViewControllerToTest;
@property (nonatomic) OFFlickrAPIContext *flickrContext;
@property (nonatomic) OFFlickrAPIRequest *flickrRequest;

@end

@interface CollectionViewController (Test)

@end

@interface DetailViewController (Test)

@end


@implementation FlickrClientTests
@synthesize collectionViewControllerToTest;
@synthesize flickrContext, flickrRequest;

- (void)setUp {
    [super setUp];

    flickrContext = [[OFFlickrAPIContext alloc] initWithAPIKey:API_KEY sharedSecret:SHARED_SECRET];
    flickrRequest = [[OFFlickrAPIRequest alloc] initWithAPIContext:flickrContext];
    [flickrRequest setDelegate:self];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


-(void)testNumberOfList
{
    if (![flickrRequest isRunning]) {
        [flickrRequest callAPIMethodWithGET:@"flickr.interestingness.getList" arguments:[NSDictionary dictionaryWithObjectsAndKeys:@"100", @"per_page", nil]];
    }
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary
{
    XCTAssertEqual(100, inResponseDictionary.count);
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didFailWithError:(NSError *)inError
{
}

- (void)testExample {
    
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
