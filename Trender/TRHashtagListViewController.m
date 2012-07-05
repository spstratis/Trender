//
//  TRHashtagListViewController.m
//  Trender
//
//  Created by Michael Reneer on 7/3/12.
//  Copyright (c) 2012 Trender. All rights reserved.
//

#import "TRHashtagListViewController.h"

#pragma mark - Interface

@interface TRHashtagListViewController ()

- (UITableViewCell *)configureFavoriteCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - Implementation

@implementation TRHashtagListViewController

//synth the hash tag from the header
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

   //check if view did load 
- (void)viewDidLoad{
    [super viewDidLoad];
    
    //create and populate array with pres'
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:3];
    [array addObject:@"#Ron Paul"];
    [array addObject:@"#Mitt Romney"];
    [array addObject:@"#Barak Obama"];
    
    //set @property hashtags to an array 
    self.hashtags = array;
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"TRHashtagCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    return [self configureFavoriteCell:cell forRowAtIndexPath:indexPath];
}

/*
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.hashtags count];
}
*/

@end
