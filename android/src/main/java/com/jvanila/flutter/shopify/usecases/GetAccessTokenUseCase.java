package com.jvanila.flutter.shopify.usecases;

import com.jvanila.flutter.plugin.arch.PluginContext;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GetAccessTokenUseCase extends ShopifyCallUseCase {

    public GetAccessTokenUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {

 /*mPluginContext.api.instance.getAccessToken(new ApiCallback<String>() {

     @Override

        public void onResult(String token) {
        result.success( token);
        }


     @Override
     public void onFailure(@NotNull Error error) {

     }

        });*/

        result.success("a4a78e07552b76eab90dba533d60e318");
    }
}
