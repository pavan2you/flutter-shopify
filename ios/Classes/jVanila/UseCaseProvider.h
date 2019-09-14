//
//  UseCaseProvider.h
//  Runner
//
//  Created by pavan on 29/03/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UseCase.h"

@class UseCase;

@interface UseCaseProvider : NSObject

-(void)registerUseCase:(NSString *)clazz with:(UseCase *)usecase;

-(UseCase *)of:(NSString *)clazz;

@end
