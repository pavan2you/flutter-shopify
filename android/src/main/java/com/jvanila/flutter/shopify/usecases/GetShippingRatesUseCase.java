package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Error;
import com.shopapp.gateway.entity.ShippingRate;
import com.shopapp.shopify.api.ShopifyApi;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GetShippingRatesUseCase extends ShopifyCallUseCase {

    private static final String ARG_CHECKOUT_ID = "checkoutId";

    public GetShippingRatesUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        String checkoutId = input.argument(ARG_CHECKOUT_ID);
        mPluginContext.api.instance.getShippingRates(checkoutId, new ApiCallback<List<ShippingRate>>() {
            @Override
            public void onResult(List<ShippingRate> shippingRates) {
                if (shippingRates != null && shippingRates.size() > 0) {

                    String ratesJsonString = new Gson().toJson(shippingRates,
                            new TypeToken<List<ShippingRate>>() {
                            }.getType());

                    result.success(ratesJsonString);
                } else {
                    System.out.println("No Shipping Rates available");
                }
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
            }
        });
    }
}
