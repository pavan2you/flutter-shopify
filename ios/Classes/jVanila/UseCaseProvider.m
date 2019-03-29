//
//  UseCaseProvider.m
//  Runner
//
//  Created by pavan on 29/03/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "UseCaseProvider.h"

@interface UseCaseProvider()

@property(nonatomic, retain) NSMutableDictionary *mRegistry;

@end

@implementation UseCaseProvider

-(id)init
{
    self = [super init];
    if (self)
    {
        _mRegistry = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)registerUseCase:(NSString *)clazz with:(UseCase *)usecase {
    [_mRegistry setValue:usecase forKey:clazz];
}

- (UseCase *)of:(NSString *)clazz {
    return [_mRegistry valueForKey:clazz];
}

@end
