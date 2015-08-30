//
//  FirstViewController.m
//  AutoDraft
//
//  Created by Green, Andrew on 8/30/15.
//  Copyright (c) 2015 Green, Andrew. All rights reserved.
//

#import "GMSAllDraftViewController.h"


@interface GMSAllDraftViewController ()

@end

@implementation GMSAllDraftViewController

- (void) viewDidAppear:(BOOL)animated
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    self.arrayToUse = [[GMSDraftManager sharedInstance] allDraftObjects];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Perform the real delete action here. Note: you may need to check editing style
    //   if you do not perform delete only.
    NSLog(@"Deleted row.");
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        GMSDraftObject *currentObject = (GMSDraftObject*)[self.arrayToUse objectAtIndex:indexPath.row];
        [[GMSDraftManager sharedInstance] eraseFromAll:currentObject];
        self.arrayToUse = [[GMSDraftManager sharedInstance] allDraftObjects];
        
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
