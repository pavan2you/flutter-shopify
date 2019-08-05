package com.jvanila.flutter.shopify.usecases;

import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Error;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GetAccessTokenUseCase extends ShopifyCallUseCase {

    public GetAccessTokenUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(final MethodCall input, final MethodChannel.Result result) {

        mPluginContext.api.instance.getAccessToken(new ApiCallback<String>() {
            @Override
            public void onResult(String token) {
                System.out.println("AccessToken -- " + token);
                result.success(token);
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
                result.error("GetAccessTokenUseCase", error.getMessage(), error);
            }
        });

        //result.success("a4a78e07552b76eab90dba533d60e318");
    }
}
