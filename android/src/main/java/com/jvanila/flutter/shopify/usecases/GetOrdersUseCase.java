package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.plugin.arch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Error;
import com.shopapp.gateway.entity.Order;
import com.shopapp.shopify.api.ShopifyApi;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GetOrdersUseCase extends ShopifyCallUseCase {

    private static final String ARG_PER_PAGE = "perPage";
    private static final String ARG_PAGINATION_VALUE = "paginationValue";

    public GetOrdersUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        int perPage = input.argument(ARG_PER_PAGE);
        Object paginationValue = input.argument(ARG_PAGINATION_VALUE);
        mPluginContext.api.instance.getOrders(perPage, paginationValue, new ApiCallback<List<Order>>() {
            @Override
            public void onResult(List<Order> orders) {
                if (orders != null && orders.size() > 0) {

                    String ordersJsonString = new Gson().toJson(orders,
                            new TypeToken<List<Order>>() {
                            }.getType());

                    result.success(ordersJsonString);
                }
                else {
                    result.success("No Orders");
                }
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
//                result.success("onFailure -- " + error);
                result.error("GetOrdersUseCase", error.getMessage(), error);
            }
        });
    }
}
