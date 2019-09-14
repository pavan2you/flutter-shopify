package com.jvanila.flutter.shopify.usecases;


import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Error;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import kotlin.Unit;

public class ChangePasswordUseCase extends ShopifyCallUseCase {

    private static final String ARG_PASSWORD = "password";

    public ChangePasswordUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        String password = input.argument(ARG_PASSWORD);
        mPluginContext.api.instance.changePassword(password, new ApiCallback<Unit>() {
            @Override
            public void onResult(Unit unit) {
                result.success(true);
            }

            @Override
            public void onFailure(Error error) {
                result.error("ChangePasswordUseCase", error.getMessage(), error);
            }
        });
    }
}
