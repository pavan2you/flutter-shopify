package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.plugin.arch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Checkout;
import com.shopapp.gateway.entity.Error;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GetCheckoutUseCase extends ShopifyCallUseCase {

    private static final String ARG_CHECKOUT_ID = "checkoutId";

    public GetCheckoutUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        String checkoutId = input.argument(ARG_CHECKOUT_ID);
        mPluginContext.api.instance.getCheckout(checkoutId, new ApiCallback<Checkout>() {
            @Override
            public void onResult(Checkout checkout) {
                if (checkout != null) {

                    String checkoutJsonString = new Gson().toJson(checkout,
                            new TypeToken<Checkout>() {
                            }.getType());

                    result.success(checkoutJsonString);
                }
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
                result.error("GetCheckoutUseCase", error.getMessage(), error);
            }
        });
    }
}
