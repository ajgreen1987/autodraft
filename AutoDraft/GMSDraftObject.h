//
//  GMSDraftObject.h
//  AutoDraft
//
//  Created by Green, Andrew on 8/30/15.
//  Copyright (c) 2015 Green, Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMSDraftObject : NSObject



/*
 {
 "playerId": "259",
 "position": "RB",
 "displayName": "Adrian Peterson",
 "fname": "Adrian",
 "lname": "Peterson",
 "team": "MIN",
 "byeWeek": "5",
 "nerdRank": "1.826",
 "positionRank": "1",
 "overallRank": "1"
 }
 */

@property (nonatomic, assign) NSInteger playerId;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *lname;
@property (nonatomic, strong) NSString *fname;
@property (nonatomic, strong) NSString *team;
@property (nonatomic, assign) NSInteger byeWeek;
@property (nonatomic, assign) float nerdRank;
@property (nonatomic, assign) float positionRank;
@property (nonatomic, assign) float overallRank;

@end
