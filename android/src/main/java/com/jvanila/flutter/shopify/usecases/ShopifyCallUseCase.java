package com.jvanila.flutter.shopify.usecases;

import com.jvanila.flutter.pluginarch.PluginContext;
import com.jvanila.flutter.pluginarch.UseCase;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * Created by pavan on 23/09/18
 */
public abstract class ShopifyCallUseCase extends
        UseCase<MethodCall, MethodChannel.Result, ShopifyApi> {

    public ShopifyCallUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }
}
