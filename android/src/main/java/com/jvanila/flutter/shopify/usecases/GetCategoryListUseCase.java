package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.plugin.arch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Category;
import com.shopapp.gateway.entity.Error;
import com.shopapp.shopify.api.ShopifyApi;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * Created by pragna on 24/09/18
 */
public class GetCategoryListUseCase extends ShopifyCallUseCase {

    private static final String ARG_PER_PAGE = "perPage";
    private static final String ARG_PAGINATION_VALUE = "paginationValue";

    public GetCategoryListUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {

        int perPage = input.argument(ARG_PER_PAGE);
        Object paginationValue = input.argument(ARG_PAGINATION_VALUE);

        mPluginContext.api.instance.getCategoryList(perPage, paginationValue, new ApiCallback<List<Category>>() {
            @Override
            public void onResult(List<Category> categories) {
                if (categories != null && categories.size() > 0) {

                    String categoriesJsonString = new Gson().toJson(categories,
                            new TypeToken<List<Category>>() {
                            }.getType());

                    result.success(categoriesJsonString);
                }
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
                result.error("GetCategoryListUseCase", error.getMessage(), error);
            }
        });
    }
}
