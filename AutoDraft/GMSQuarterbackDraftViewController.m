//
//  SecondViewController.m
//  AutoDraft
//
//  Created by Green, Andrew on 8/30/15.
//  Copyright (c) 2015 Green, Andrew. All rights reserved.
//

#import "GMSQuarterbackDraftViewController.h"

@implementation GMSQuarterbackDraftViewController

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.arrayToUse = [[GMSDraftManager sharedInstance] quarterBacks];
    }
    
    return self;
}

@end