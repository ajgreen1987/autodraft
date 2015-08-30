//
//  GMSKickerDraftViewController.m
//  AutoDraft
//
//  Created by Green, Andrew on 8/30/15.
//  Copyright (c) 2015 Green, Andrew. All rights reserved.
//

#import "GMSKickerDraftViewController.h"

@implementation GMSKickerDraftViewController

- (void) viewWillAppear:(BOOL)animated
{
    self.arrayToUse = [[GMSDraftManager sharedInstance] kickers];
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
        self.arrayToUse = [[GMSDraftManager sharedInstance] kickers];
        
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
