//
//  ShopifyPlugin.m
//  Runner
//
//  Created by pavan on 29/03/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "ShopifyPlugin.h"
#import "Plugin.h"
#import "ClosePluginUseCase.h"
#import "GetPlatformVersionUseCase.h"
#import "shopify/shopify-Swift.h"

@implementation ShopifyPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    ShopifyPlugin *plugin = [[ShopifyPlugin alloc]
                             initWith:@"shopify"
                             withRegistrar:registrar
                             withApi:[[Api alloc] init]];
    [plugin description];//patch fix
}

-(void)onCreateUseCasesWith:(UseCaseProvider *)provider
{
    [provider registerUseCase:@"close"
        with:[[ClosePluginUseCase alloc] initWith:self.mPluginContext]];
    [provider registerUseCase:@"getPlatformVersion"
        with:[[GetPlatformVersionUseCase alloc] initWith:self.mPluginContext]];
    [provider registerUseCase:@"initialize"
                         with:[[InitializeUseCase alloc]initWith:self.mPluginContext]];
}

@end
