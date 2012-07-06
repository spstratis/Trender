//
//  TRHashtagListViewController.m
//  Trender
//
//  Created by Michael Reneer on 7/3/12.
//  Copyright (c) 2012 Trender. All rights reserved.
//

#import "TRFavorite.h"
#import "TRFavoriteListViewController.h"
#import "TRHashtagListViewController.h"

#pragma mark - Interface

@interface TRHashtagListViewController ()

// TODO: explain why this should be weak
@property (nonatomic, strong) TRFavoriteListViewController *favoriteListController;

- (UITableViewCell *)configureFavoriteCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - Implementation

@implementation TRHashtagListViewController

@synthesize favoriteListController;
@synthesize hashtags;

//if view is not laoded
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if (![self isViewLoaded]) {
        self.hashtags = nil;
    }
}

//check orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    UIDevice *device = [UIDevice currentDevice];
    
    if (device.userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
    }
    else {
        return YES;
    }
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    self.favoriteListController = [segue destinationViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.favoriteListController != nil) {
        TRFavorite *favorite = self.favoriteListController.selectedFavorite;
        
        self.hashtags = favorite.hashtags;
        self.title = favorite.name;
        
        [self.tableView reloadData];
    }
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}








-(void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark - Instance Method

//create the cell
- (UITableViewCell *)configureFavoriteCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.text = [self.hashtags objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - protocal methods - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"TRHashtagCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    return [self configureFavoriteCell:cell forRowAtIndexPath:indexPath];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.hashtags count];
}

@end
