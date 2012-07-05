//
//  TRFavoriteListViewController.m
//  Trender
//
//  Created by Michael Reneer on 7/3/12.
//  Copyright (c) 2012 Michael Reneer. All rights reserved.
//

#import "TRFavoriteListViewController.h"

#pragma mark - Interface

@interface TRFavoriteListViewController ()

- (UITableViewCell *)configureFavoriteCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - Implementation

@implementation TRFavoriteListViewController

#pragma mark - Instance Properties

@synthesize favorites;
@synthesize selectedHashtags;

#pragma mark - Overriden Method

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if (![self isViewLoaded]) {
        self.favorites = nil;
        self.selectedHashtags = nil;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    UIDevice *device = [UIDevice currentDevice];
    
    if (device.userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
    }
    else {
        return YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TODO: don't hardcode
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:2];
    [array addObject:@"Presidents"];
    [array addObject:@"Restaurants"];
    
    self.favorites = array;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark - Instance Method

- (UITableViewCell *)configureFavoriteCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = [self.favorites objectAtIndex:indexPath.row];
    
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
    // TODO: set selected hashtags
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
