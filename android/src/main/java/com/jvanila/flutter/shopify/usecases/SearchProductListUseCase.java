package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.plugin.arch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Error;
import com.shopapp.gateway.entity.Product;
import com.shopapp.shopify.api.ShopifyApi;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class SearchProductListUseCase extends ShopifyCallUseCase {

    private static final String ARG_PER_PAGE = "perPage";
    private static final String ARG_PAGINATION_VALUE = "paginationValue";
    private static final String ARG_QUERY = "query";

    public SearchProductListUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        int perPage = input.argument(ARG_PER_PAGE);
        Object paginationValue = input.argument(ARG_PAGINATION_VALUE);
        String query = input.argument(ARG_QUERY);

        mPluginContext.api.instance.searchProductList(perPage, paginationValue, query,
                new ApiCallback<List<Product>>() {
                    @Override
                    public void onResult(List<Product> products) {
                        if (products != null && products.size() > 0) {
                            String productJsonString = new Gson().toJson(products,
                                    new TypeToken<List<Product>>() {
                                    }.getType());
                            result.success(productJsonString);
                        }
                    }

                    @Override
                    public void onFailure(Error error) {
                        System.out.println("onFailure -- " + error);
                        result.error("SearchProductListUseCase", error.getMessage(), error);
                    }
                });
    }
}
