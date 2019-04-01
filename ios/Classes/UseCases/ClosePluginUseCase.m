//
//  ClosePluginUseCase.m
//  Runner
//
//  Created by pavan on 29/03/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "ClosePluginUseCase.h"

@implementation ClosePluginUseCase

-(void)triggerWithMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    [self.mContext.plugin onDestroy];
    result(@"success");
}

@end
