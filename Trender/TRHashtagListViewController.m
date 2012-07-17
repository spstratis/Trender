//
//  TRHashtagListViewController.m
//  Trender
//
//  Created by Michael Reneer on 7/3/12.
//  Copyright (c) 2012 Trender. All rights reserved.
//

#import <Twitter/Twitter.h>
#import "TRFavorite.h"
#import "TRFavoriteListViewController.h"
#import "TRHashtag.h"
#import "TRHashtagListViewController.h"

#pragma mark - Interface

// ???: define private interface
@interface TRHashtagListViewController ()

// ???: explain why this is weak
@property (nonatomic, weak) TRFavoriteListViewController *favoriteListController;

- (UITableViewCell *)configureFavoriteCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)requestRankForHashtag:(TRHashtag *)hashtag;

@end

#pragma mark - Implementation

// ???: define implementation
@implementation TRHashtagListViewController

#pragma mark - Constants

static NSString *const kNameOfFavoriteListSegue = @"FavoriteListSegue";

#pragma mark - Instance Properties

@synthesize favoriteListController;
@synthesize hashtags;

#pragma mark - Overriden Methods

// ???: when the controller should handle a memory warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // ???: if the controllers view is not visible free up as much memory as possible
    if (![self isViewLoaded]) {
        self.hashtags = nil;
    }
}

// ???: when the device rotates the view asks the controller if it can rotate as well
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    UIDevice *device = [UIDevice currentDevice];
    
    // ???: if device is iPhone rotate if not upside down
    if (device.userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    }
    
    // ??? if deivec is iPad always rotate
    else {
        return YES;
    }
}

// ???: when the controller performs a segue 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    // ???: could be one of many segues, so choose the correct one
    if ([segue.identifier isEqualToString:(NSString *)kNameOfFavoriteListSegue]) {
        
        // ???: remember the favorite list controller
        self.favoriteListController = [segue destinationViewController];
    }
}

// ???: when the controllers view will appear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // ???: if the favorite list controller is set, load the selected favorite object
    if (self.favoriteListController != nil) {
        TRFavorite *favorite = self.favoriteListController.selectedFavorite;
        
        self.hashtags = favorite.hashtags;
        self.title = favorite.name;
        
        for (TRHashtag *hashtag in self.hashtags) {
            [self requestRankForHashtag:hashtag];
        }
        
        [self.tableView reloadData];
    }
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

// ???: when the controller did unload
- (void)viewDidUnload {
    [super viewDidUnload];
    
    // ???: free up all memory
}

#pragma mark - Instance Method

// TODO: clean up
- (UITableViewCell *)configureFavoriteCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSTimeInterval total = 0.0f;
    
    for (TRHashtag *hashtag in self.hashtags) {
        total = total + hashtag.timeIntervalOfLatestMentions;
    }
    
    TRHashtag *hashtag = [self.hashtags objectAtIndex:indexPath.row];
    
    NSTimeInterval ratio = (total - hashtag.timeIntervalOfLatestMentions) / (total * 2);
    
    cell.textLabel.text = hashtag.name;
    
    if (ratio == ratio) {
        NSNumber *number = [[NSNumber alloc] initWithDouble:ratio];
        
        // TODO: cache formatter
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.maximumFractionDigits = 1;
        formatter.numberStyle = NSNumberFormatterPercentStyle;
        formatter.usesGroupingSeparator = NO;
        
        cell.detailTextLabel.text = [formatter stringFromNumber:number];
    }
    else {
        cell.detailTextLabel.text = nil;
    }
    
    return cell;
}

// TODO: clean up
- (void)requestRankForHashtag:(TRHashtag *)hashtag {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:hashtag.name forKey:@"q"];
    [parameters setObject:@"100" forKey:@"rpp"];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://search.twitter.com/search.json"];
    
    TWRequestHandler handler = ^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if (responseData) {
            NSError *error;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
            
            if (error == nil) {
                NSArray *tweets = [response objectForKey:@"results"];
                
                // TODO: cache formatter
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"E, dd MMM yyy HH:mm:ss ZZZ";
                
//                NSDictionary *firstTweet = [tweets objectAtIndex:0];
//                NSString *firstDateString = [firstTweet objectForKey:@"created_at"];
//                NSDate *firstDate = [formatter dateFromString:firstDateString];
//                NSTimeInterval firstInterval = [firstDate timeIntervalSince1970];
                
                NSDictionary *lastTweet = [tweets lastObject];
                NSString *lastDateString = [lastTweet objectForKey:@"created_at"];
                NSDate *lastDate = [formatter dateFromString:lastDateString];
                
                NSLog(@" ");
                NSLog(@"---------- %@", hashtag.name);
                NSLog(@"last = %@", lastDate);
                NSLog(@"seconds = %f", [lastDate timeIntervalSinceNow]);
                
                hashtag.timeIntervalOfLatestMentions = [lastDate timeIntervalSinceNow];
                
                [self.tableView reloadData];
            } 
            else { 
                NSLog(@"%@", error);
            }
        }
    };
    
    TWRequest *request = [[TWRequest alloc] initWithURL:url parameters:parameters requestMethod:TWRequestMethodGET];
    [request performRequestWithHandler:handler];
}

#pragma mark - Protocal Methods - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}	

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"TRHashtagCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    return [self configureFavoriteCell:cell forRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.hashtags count];
}
	
#pragma mark - Protocol Method - UITableViewDelegate
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        TRHashtag *hashtag = [self.hashtags objectAtIndex:indexPath.row];
        //TODO:: Delete hashtag from hashtag array
        
        NSArray *IndexPaths =[[NSArray alloc] initWithObjects:indexPath, nil];
        
        [tableView deleteRowsAtIndexPaths:IndexPaths withRowAnimation:UITableViewRowAnimationFade];
       
    }
}


@end
