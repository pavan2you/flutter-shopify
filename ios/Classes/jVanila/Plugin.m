//
//  Plugin.m
//  Runner
//
//  Created by pavan on 29/03/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "Plugin.h"
#import "UseCaseProvider.h"

@implementation Plugin

+ (void)registerWithRegistrar:(nonnull NSObject<FlutterPluginRegistrar> *)registrar {
    //Subclasses must override this
}

-(id)initWith:(NSString *)name withRegistrar:(nonnull NSObject<FlutterPluginRegistrar> *)registrar withApi:(Api *)api {
    self = [super init];
    if (self)
    {
        FlutterMethodChannel* channel = [FlutterMethodChannel
                                         methodChannelWithName:name
                                         binaryMessenger:[registrar messenger]];
        [registrar addMethodCallDelegate:self channel:channel];
        
        _mPluginContext = [[PluginContext alloc] init];
        _mPluginContext.api = api;
        _mPluginContext.plugin = self;
        
        _mUseCaseProvider = [[UseCaseProvider alloc] init];
        [self onCreateUseCasesWith:_mUseCaseProvider];
    }
    return self;
}

-(void)onCreateUseCasesWith:(UseCaseProvider *)provider {
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    FlutterResult asyncResult = ^(id res) {
        dispatch_async(dispatch_get_main_queue(), ^{
            result(res);
        });
    };
    
    [[self.mUseCaseProvider of:call.method] executeWithMethodCall:call result:asyncResult];
}

-(void)onDestroy {
    
}

@end
