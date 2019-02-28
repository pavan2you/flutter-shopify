package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.plugin.arch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Error;
import com.shopapp.gateway.entity.Order;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GetOrderUseCase extends ShopifyCallUseCase {

    private static final String ARG_ORDER_ID = "orderId";

    public GetOrderUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        String orderId = input.argument(ARG_ORDER_ID);
        mPluginContext.api.instance.getOrder(orderId, new ApiCallback<Order>() {
            @Override
            public void onResult(Order order) {
                if (order != null) {

                    String orderJsonString = new Gson().toJson(order,
                            new TypeToken<Order>() {
                            }.getType());

                    result.success(orderJsonString);
                }
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
                result.error("GetOrderUseCase", error.getMessage(), error);
            }
        });
    }
}
