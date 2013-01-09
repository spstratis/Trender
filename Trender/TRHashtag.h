//
//  TRHashtag.h
//  Trender
//
//  Created by Michael Reneer on 7/9/12.
//  Copyright (c) 2012 Trender. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

#pragma mark - Interface

@interface TRHashtag : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSTimeInterval timeIntervalOfLatestMentions;

@end
