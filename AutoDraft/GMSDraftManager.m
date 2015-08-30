//
//  GMSDraftManager.m
//  AutoDraft
//
//  Created by Green, Andrew on 8/30/15.
//  Copyright (c) 2015 Green, Andrew. All rights reserved.
//

#import "GMSDraftManager.h"
#import "GMSDraftObject.h"
#import <objc/runtime.h>

#define FFN_API_KEY             @"ymrnstaij8h9"
#define FFN_RETURN_TYPE         @"json"
#define FFN_DRAFT_BASE_URL      @"http://www.fantasyfootballnerd.com/service"
#define FFN_DRAFT_RANKINGS_URL  @"draft-rankings"
#define FFN_DRAFT_RANKINGS_KEY  @"DraftRankings"
#define FFN_QUARTERBACK_KEY     @"QB"
#define FFN_RUNNINGBACK_KEY     @"RB"
#define FFN_WIDERECEIVER_KEY    @"WR"
#define FFN_TIGHTEND_KEY        @"TE"
#define FFN_KICKER_KEY          @"K"
#define FFN_DEFENSE_KEY         @"DEF"

static GMSDraftManager *sharedInstance;

@implementation GMSDraftManager

+ (instancetype)sharedInstance
{
    if (sharedInstance == nil)
    {
        sharedInstance = [[GMSDraftManager alloc] init];
    }
    
    return sharedInstance;
}


- (NSDictionary *) retrieveDraftObjects:(NSURL*)aURL
{
    NSData *jsonData = [NSData dataWithContentsOfURL:aURL];
    
    
    if(jsonData != nil)
    {
        NSError *error = nil;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        NSDictionary *draftRankings = [result objectForKey:FFN_DRAFT_RANKINGS_KEY];
        
        if (error == nil)
        {
            NSLog(@"%@", result);
            return draftRankings;
        }
    }
    
    return nil;
}

- (NSArray*) parseDraftObjects:(NSDictionary*)toParse
{
    unsigned int count = 0;
    // Get a list of all properties in the class.
    objc_property_t *properties = class_copyPropertyList([GMSDraftObject class], &count);
    
    NSMutableArray *toReturn = [[NSMutableArray alloc] init];
    
    for (NSDictionary *object in toParse)
    {
        GMSDraftObject *newDraftObject = [[GMSDraftObject alloc] init];
        
        for (int i=0; i<count; i++)
        {
            NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
            NSLog(@"%@",key);
            
            [newDraftObject setValue:[object objectForKey:key] forKey:key];
        }
        
        [toReturn addObject:newDraftObject];
    }
    
    return [toReturn copy];
}

- (void) eraseFromAll:(GMSDraftObject*)draftObject 
{
    [self eraseObject:draftObject fromArray:_allDraftObjects];    
}

- (NSMutableArray*) allDraftObjects
{
    if ([_allDraftObjects count] < 1)
    {
        NSString *draftRankingsURLString = [NSString stringWithFormat:@"%@/%@/%@/%@",FFN_DRAFT_BASE_URL,FFN_DRAFT_RANKINGS_URL, FFN_RETURN_TYPE, FFN_API_KEY];
        NSURL *draftRankingsURL = [NSURL URLWithString:draftRankingsURLString];
        
        _allDraftObjects = [[NSMutableArray alloc] initWithArray:[self parseDraftObjects:[self retrieveDraftObjects:draftRankingsURL]]];
    }
    
    return _allDraftObjects;
}

- (NSMutableArray*) quarterBacks
{
    _quarterBacks = [self setupSubArray:_quarterBacks
                     fromArray:_allDraftObjects
           withPredicateString:[self predicateStringForKey:FFN_QUARTERBACK_KEY]];
    
    return _quarterBacks;
}

- (NSMutableArray*) wideReceivers
{
    _wideReceivers = [self setupSubArray:_wideReceivers
                     fromArray:_allDraftObjects
           withPredicateString:[self predicateStringForKey:FFN_WIDERECEIVER_KEY]];
    
    return _wideReceivers;
}

- (NSMutableArray*) tightEnds
{
    return [self setupSubArray:_tightEnds
                     fromArray:_allDraftObjects
           withPredicateString:[self predicateStringForKey:FFN_TIGHTEND_KEY]];
}

- (NSMutableArray*) runningBacks
{
    _runningBacks = [self setupSubArray:_runningBacks
                     fromArray:_allDraftObjects
           withPredicateString:[self predicateStringForKey:FFN_RUNNINGBACK_KEY]];
    
    return _runningBacks;
}

- (NSMutableArray*) kickers
{
    return [self setupSubArray:_kickers
                     fromArray:_allDraftObjects
           withPredicateString:[self predicateStringForKey:FFN_KICKER_KEY]];
}

- (NSMutableArray*) defenses
{
    return [self setupSubArray:_defenses
                     fromArray:_allDraftObjects
           withPredicateString:[self predicateStringForKey:FFN_DEFENSE_KEY]];
}

- (NSString*) predicateStringForKey:(NSString*)aKey
{
    return [NSString stringWithFormat:@"self.position CONTAINS '%@'",aKey];
}

- (NSMutableArray*) setupSubArray:(NSMutableArray*)aMutableArray fromArray:(NSMutableArray*)aMasterArray withPredicateString:(NSString*)aPredicateString
{
    aMutableArray = nil;
    aMutableArray = [[NSMutableArray alloc] initWithArray:[aMasterArray filteredArrayUsingPredicate:[self predicateFromString:aPredicateString]]];
    
    return aMutableArray;
}

- (NSPredicate*) predicateFromString:(NSString*)aString
{
    return [NSPredicate predicateWithFormat:aString];
}

- (void) eraseObject:(GMSDraftObject*)anObject fromArray:(NSMutableArray*)anArray
{
    [anArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(GMSDraftObject *currentDraftObject, NSUInteger index, BOOL *stop) {
        if (currentDraftObject.playerId == anObject.playerId)
        {
            [anArray removeObjectAtIndex:index];
        }
    }];
}

@end
