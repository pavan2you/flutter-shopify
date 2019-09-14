//
//  GetPlatformVersionUseCase.m
//  Runner
//
//  Created by pavan on 29/03/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "GetPlatformVersionUseCase.h"

@implementation GetPlatformVersionUseCase

-(void)triggerWithMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
}

@end
