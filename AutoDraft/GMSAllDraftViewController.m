//
//  FirstViewController.m
//  AutoDraft
//
//  Created by Green, Andrew on 8/30/15.
//  Copyright (c) 2015 Green, Andrew. All rights reserved.
//

#import "GMSAllDraftViewController.h"
#import "DGActivityIndicatorView.h"


@interface GMSAllDraftViewController ()

@property (nonatomic, strong) DGActivityIndicatorView *activityIndicatorView;

@end

@implementation GMSAllDraftViewController

- (void) viewDidAppear:(BOOL)animated
{

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //Start an activity indicator here
    GMSAllDraftViewController __weak *threadSafeSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //Call your function or whatever work that needs to be done
        //Code in this part is run on a background thread
        threadSafeSelf.arrayToUse = [[GMSDraftManager sharedInstance] allDraftObjects];

        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            //Stop your activity indicator or anything else with the GUI
            //Code here is run on the main thread
            [threadSafeSelf.tableView reloadData];
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
        });
    });
    
    

    
    [self stopAndRemoveActivityIndicator];
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

- (void) setupAndStartActivityIndicator
{
    self.activityIndicatorView= [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeDoubleBounce tintColor:[UIColor blackColor] size:20.0f];
    self.activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);
    
    [self.activityIndicatorView startAnimating];
}

- (void) stopAndRemoveActivityIndicator
{
    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView removeFromSuperview];
}

@end
