package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Checkout;
import com.shopapp.gateway.entity.Error;
import com.shopapp.gateway.entity.ShippingRate;
import com.shopapp.shopify.api.ShopifyApi;

import java.math.BigDecimal;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class SelectShippingRateUseCase extends ShopifyCallUseCase {

    private static final String ARG_CHECKOUT_ID = "checkoutId";
    private static final String ARG_TITLE = "title";
    private static final String ARG_PRICE = "price";
    private static final String ARG_HANDLE = "handle";

    public SelectShippingRateUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        String checkoutId = input.argument(ARG_CHECKOUT_ID);
        String title = input.argument(ARG_TITLE);
        double price = input.argument(ARG_PRICE);
        String handle = input.argument(ARG_HANDLE);
        ShippingRate rate = new ShippingRate(title, new BigDecimal(price), handle);
        mPluginContext.api.instance.selectShippingRate(checkoutId, rate, new ApiCallback<Checkout>() {
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
            }
        });
    }
}
