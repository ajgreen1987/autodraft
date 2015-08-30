//
//  GMSDraftManager.h
//  AutoDraft
//
//  Created by Green, Andrew on 8/30/15.
//  Copyright (c) 2015 Green, Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GMSDraftObject;

@interface GMSDraftManager : NSObject

@property (nonatomic, strong) NSMutableArray *allDraftObjects;
@property (nonatomic, strong) NSMutableArray *quarterBacks;
@property (nonatomic, strong) NSMutableArray *wideReceivers;
@property (nonatomic, strong) NSMutableArray *tightEnds;
@property (nonatomic, strong) NSMutableArray *runningBacks;
@property (nonatomic, strong) NSMutableArray *kickers;
@property (nonatomic, strong) NSMutableArray *defenses;

+ (instancetype) sharedInstance;

- (void) eraseFromAll:(GMSDraftObject*)draftObject;


@end
