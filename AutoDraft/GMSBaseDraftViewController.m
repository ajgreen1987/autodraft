//
//  GMSBaseDraftViewController.m
//  AutoDraft
//
//  Created by Green, Andrew on 8/30/15.
//  Copyright (c) 2015 Green, Andrew. All rights reserved.
//

#import "GMSBaseDraftViewController.h"

@implementation GMSBaseDraftViewController

- (void) viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

#pragma mark - Tableview Datasource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayToUse count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMSDraftObject *currentObject = [self.arrayToUse objectAtIndex:indexPath.row];
    
    NSString *simpleTableIdentifier = [NSString stringWithFormat:@"SimpleTableItem:%li",currentObject.playerId];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
        [[cell textLabel] setText:currentObject.displayName];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return YES - we will be able to delete all rows
    return YES;
}

@end
