//
//  GMSBaseDraftViewController.h
//  AutoDraft
//
//  Created by Green, Andrew on 8/30/15.
//  Copyright (c) 2015 Green, Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMSDraftManager.h"
#import "GMSDraftObject.h"

@interface GMSBaseDraftViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayToUse;

@end
