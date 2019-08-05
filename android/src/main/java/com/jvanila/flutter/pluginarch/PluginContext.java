package com.jvanila.flutter.pluginarch;

import android.os.Handler;

import com.jvanila.flutter.api.Api;


/**
 * Created by pavan on 23/09/18
 */
public class PluginContext<T> {

    public Plugin<T> plugin;
    public Api<T> api;
    public Handler executor;
    public boolean debug;

    public static boolean isDirty(PluginContext<?> context) {
        return context == null || context.plugin == null || context.api == null ||
                context.executor == null;
    }
}
