//
//  GMSBaseDraftViewController.m
//  AutoDraft
//
//  Created by Green, Andrew on 8/30/15.
//  Copyright (c) 2015 Green, Andrew. All rights reserved.
//

#import "GMSBaseDraftViewController.h"

@implementation GMSBaseDraftViewController

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
    
    NSString *simpleTableIdentifier = [NSString stringWithFormat:@"SimpleTableItem:%li%li", (long)indexPath.section, (long)indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
        [[cell textLabel] setText:currentObject.displayName];
    }
    
    return cell;
}

#pragma mark - Tableview Delegate

@end
