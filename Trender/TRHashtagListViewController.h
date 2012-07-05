//
//  TRHashtagListViewController.h
//  Trender
//
//  Created by Michael Reneer on 7/3/12.
//  Copyright (c) 2012 Trender. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Interface

// TODO: create hash tag array property (done)
// TODO: init array with hash tags of presidents (done)

// TODO: wire with number of columsn, number of rows, cell for index (in progress)
@interface TRHashtagListViewController : UITableViewController

@property (nonatomic, strong) NSArray *hashtags;

@end
