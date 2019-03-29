//
//  Plugin.h
//  Runner
//
//  Created by pavan on 29/03/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "Api.h"
#import "UseCaseProvider.h"

@class Api;
@class UseCaseProvider;
@class PluginContext;

@interface Plugin : NSObject<FlutterPlugin>

@property(nonatomic, strong) UseCaseProvider *mUseCaseProvider;
@property(nonatomic, strong) PluginContext *mPluginContext;

-(id)initWith:(NSString *)name withRegistrar:(nonnull NSObject<FlutterPluginRegistrar> *)registrar withApi:(Api *)api;

-(void)onCreateUseCasesWith:(UseCaseProvider *)provider;

-(void)onDestroy;

@end
