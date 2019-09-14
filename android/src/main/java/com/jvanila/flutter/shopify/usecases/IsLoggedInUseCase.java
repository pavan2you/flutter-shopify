package com.jvanila.flutter.shopify.usecases;

import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Error;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class IsLoggedInUseCase extends ShopifyCallUseCase {
    public IsLoggedInUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        mPluginContext.api.instance.isLoggedIn(new ApiCallback<Boolean>() {
            @Override
            public void onResult(Boolean aBoolean) {
                result.success(aBoolean);
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
                result.error("IsLoggedInUseCase", error.getMessage(), error);
            }
        });
    }
}
