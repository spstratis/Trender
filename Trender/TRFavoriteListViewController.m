//
//  TRFavoriteListViewController.m
//  Trender
//
//  Created by Michael Reneer on 7/3/12.
//  Copyright (c) 2012 Trender. All rights reserved.
//

#import "TRFavorite.h"
#import "TRFavoriteListViewController.h"
#import "TRHashtag.h"

#pragma mark - Interface

@interface TRFavoriteListViewController ()

- (UITableViewCell *)configureFavoriteCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - Implementation

@implementation TRFavoriteListViewController

#pragma mark - Instance Properties

@synthesize favorites;
@synthesize selectedFavorite;

#pragma mark - Overriden Method

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if (![self isViewLoaded]) {
        self.favorites = nil;
        self.selectedFavorite = nil;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    UIDevice *device = [UIDevice currentDevice];
    
    if (device.userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    }
    else {
        return YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // !!!: don't hardcode
    TRHashtag *hashtag1 = [[TRHashtag alloc] init];
    hashtag1.name = @"#RonPaul";
    
    TRHashtag *hashtag2 = [[TRHashtag alloc] init];
    hashtag2.name = @"#MittRomney";
    
    TRHashtag *hashtag3 = [[TRHashtag alloc] init];
    hashtag3.name = @"#BarakObama";
    
    NSMutableArray *hashtags1 = [[NSMutableArray alloc] initWithCapacity:3];
    [hashtags1 addObject:hashtag1];
    [hashtags1 addObject:hashtag2];
    [hashtags1 addObject:hashtag3];
    
    TRFavorite *favorite1 = [[TRFavorite alloc] init];
    favorite1.hashtags = hashtags1;
    favorite1.name = @"Presidents";
    
    TRHashtag *hashtag4 = [[TRHashtag alloc] init];
    hashtag4.name = @"#BugerKing";
    
    TRHashtag *hashtag5 = [[TRHashtag alloc] init];
    hashtag5.name = @"#TacoBell";
    
    NSMutableArray *hashtags2 = [[NSMutableArray alloc] initWithCapacity:3];
    [hashtags2 addObject:hashtag4];
    [hashtags2 addObject:hashtag5];
    
    TRFavorite *favorite2 = [[TRFavorite alloc] init];
    favorite2.hashtags = hashtags2;
    favorite2.name = @"Restaurants";
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:2];
    [array addObject:favorite1];
    [array addObject:favorite2];
    // !!!: don't hardcode
    
    self.favorites = array;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark - Instance Method

- (UITableViewCell *)configureFavoriteCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    TRFavorite *favorite = [self.favorites objectAtIndex:indexPath.row];
    
    cell.textLabel.text = favorite.name;
    
    return cell;
}

#pragma mark - Protocol Methods - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"TRFavoriteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    return [self configureFavoriteCell:cell forRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.favorites count];
}

#pragma mark - Protocol Method - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedFavorite = [self.favorites objectAtIndex:indexPath.row];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end

