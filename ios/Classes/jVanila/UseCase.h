//
//  UseCase.h
//  Runner
//
//  Created by pavan on 29/03/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "PluginContext.h"

@class PluginContext;

@interface UseCase : NSObject

@property(nonatomic, retain) PluginContext *mContext;

-(id)initWith:(PluginContext *)context;
-(void)executeWithMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result;
-(void)triggerWithMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result;
- (void)createErrorWithCase:(NSString *)errorCase message:(NSString*)errorMessage error:(id) errorObj on:(FlutterResult)result;

@end
