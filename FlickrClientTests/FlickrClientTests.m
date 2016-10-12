//
//  FlickrClientTests.m
//  FlickrClientTests
//
//  Created by nsn on 10/5/16.
//  Copyright © 2016 nex sn. All rights reserved.
//
#import <XCTest/XCTest.h>

@interface FlickrClientTests : XCTestCase
@property (nonatomic) NSArray *photos;
@end

@implementation FlickrClientTests
@synthesize photos;

- (void)setUp {
    [super setUp];
    
    photos = @[@{
                   @"farm" : @9,
                   @"id" : @30237366785,
                   @"isfamily" : @0,
                   @"isfriend" : @0,
                   @"ispublic" : @1,
                   @"owner" : @"94321001@N00",
                   @"secret" : @"ccede102a5",
                   @"server" : @8269,
                   @"title" : @"sun always shines in the wonderland"
                   },
  @{
                   @"farm" : @6,
                   @"id" : @29928377370,
                   @"isfamily" : @0,
                   @"isfriend" : @0,
                   @"ispublic" : @1,
                   @"owner" : @"54683012@N04",
                   @"secret" : @"09567dff1f",
                   @"server" : @5560,
                   @"title" : @"Moonrays"
                   },
  @{
                   @"farm" : @8,
                   @"id" : @30197125866,
                   @"isfamily" : @0,
                   @"isfriend" : @0,
                   @"ispublic" : @1,
                   @"owner" : @"135352533@N06",
                   @"secret" : @"39c66b90ee",
                   @"server" : @7479,
                   @"title" : @"Sunset Blush"
                   },
  @{
                   @"farm" : @6,
                   @"id" : @30235505715,
                   @"isfamily" : @0,
                   @"isfriend" : @0,
                   @"ispublic" : @1,
                   @"owner" : @"34430197@N04",
                   @"secret" : @"f2a25832ef",
                   @"server" : @5565,
                   @"title" : @"Autumn Bride At The Lake"
                   },
  @{
                   @"farm" : @9,
                   @"id" : @30238735465,
                   @"isfamily" : @0,
                   @"isfriend" : @0,
                   @"ispublic" : @1,
                   @"owner" : @"86581473@N00",
                   @"secret" : @"bb00c98896",
                   @"server" : @8554,
                   @"title" : @"\"Earth To Earth, Ashes To Ashes, Dust To Dust\"",
                   },
  @{
                   @"farm" : @9,
                   @"id" : @30228320215,
                   @"isfamily" : @0,
                   @"isfriend" : @0,
                   @"ispublic" : @1,
                   @"owner" : @"37834207@N06",
                   @"secret" : @"afa94e096f",
                   @"server" : @8275,
                   @"title" : @"October Orange....Northern Red Bishop San Jaoquin Wildlife Sanctuary 570"
                   },
  @{
                   @"farm" : @9,
                   @"id" : @29941176440,
                   @"isfamily" : @0,
                   @"isfriend" : @0,
                   @"ispublic" : @1,
                   @"owner" : @"91805169@N04",
                   @"secret" : @"337d61cc64",
                   @"server" : @8547,
                   @"title" : @"pinned to clouds"
                   },
  @{
                   @"farm" : @8,
                   @"id" : @29608795943,
                   @"isfamily" : @0,
                   @"isfriend" : @0,
                   @"ispublic" : @1,
                   @"owner" : @"69349549@N06",
                   @"secret" : @"3275c77bc0",
                   @"server" : @7566,
                   @"title" : @"Le crayon se fait une bonne mine."
                   },
  @{
                   @"farm" : @9,
                   @"id" : @30197235186,
                   @"isfamily" : @0,
                   @"isfriend" : @0,
                   @"ispublic" : @1,
                   @"owner" : @"129104565@N06",
                   @"secret" : @"51330da294",
                   @"server" : @8695,
                   @"title" : @"Pink Pen"
                   },
  @{
                   @"farm" : @6,
                   @"id" : @30190039616,
                   @"isfamily" : @0,
                   @"isfriend" : @0,
                   @"ispublic" : @1,
                   @"owner" : @"60254547@N03",
                   @"secret" : @"0f127f1eea",
                   @"server" : @5459,
                   @"title" : @"Make No Mistake"
                   }];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


-(void)testPhotoData
{

    for (NSDictionary *photo in photos)
    {
        XCTAssertNotNil([photo objectForKey:@"farm"]);
        XCTAssertNotNil([photo objectForKey:@"id"]);
        XCTAssertNotNil([photo objectForKey:@"owner"]);
        XCTAssertNotNil([photo objectForKey:@"secret"]);
        XCTAssertNotNil([photo objectForKey:@"server"]);

    }
}

//- (void)testExample {
//    
//    NSLog(@"in Test Example");
//    // This is an example of a functional test case.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
