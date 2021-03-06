//
//  TRFavoriteListViewController.h
//  Trender
//
//  Created by Michael Reneer on 7/3/12.
//  Copyright (c) 2012 Trender. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TRFavorite;

#pragma mark - Interface

@interface TRFavoriteListViewController : UITableViewController

@property (nonatomic, strong) NSArray *favorites;
@property (nonatomic, strong) TRFavorite *selectedFavorite;

@end
