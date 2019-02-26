package com.jvanila.flutter.shopify.usecases;

import com.jvanila.flutter.plugin.arch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Error;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import kotlin.Unit;

public class ForgotPasswordUseCase extends ShopifyCallUseCase {

    private static final String ARG_EMAIL = "email";

    public ForgotPasswordUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        String email = input.argument(ARG_EMAIL);
        mPluginContext.api.instance.forgotPassword(email, new ApiCallback<Unit>() {
            @Override
            public void onResult(Unit unit) {
                result.success(true);
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
                result.error("ForgotPasswordUseCase", error.getMessage(), error);
            }
        });
    }
}
