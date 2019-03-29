//
//  PluginContext.h
//  Runner
//
//  Created by pavan on 29/03/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Api.h"
#import "Plugin.h"

@class Api;
@class Plugin;

@interface PluginContext : NSObject

@property (nonatomic, retain) Api *api;
@property (nonatomic, retain) Plugin *plugin;

@end
