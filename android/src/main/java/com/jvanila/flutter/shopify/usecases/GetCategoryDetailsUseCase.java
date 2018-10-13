package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.plugin.arch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Category;
import com.shopapp.gateway.entity.Error;
import com.shopapp.gateway.entity.SortType;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * Created by pragna on 24/09/18
 */
public class GetCategoryDetailsUseCase extends ShopifyCallUseCase {

    private static final String ARG_PER_PAGE = "perPage";
    private static final String ARG_PAGINATION_VALUE = "paginationValue";
    private static final String ARG_CATEGORY_ID = "categoryId";
    private static final String ARG_SORT_BY = "sortBy";

    public GetCategoryDetailsUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {

        String categoryId = input.argument(ARG_CATEGORY_ID);
        int perPage = input.argument(ARG_PER_PAGE);
        Object paginationValue = input.argument(ARG_PAGINATION_VALUE);
        SortType sortType = input.argument(ARG_SORT_BY);

        mPluginContext.api.instance.getCategoryDetails(categoryId, perPage, paginationValue, sortType,
                new ApiCallback<Category>() {
                    @Override
                    public void onResult(Category category) {
                        if (category != null) {

                            String categoryJsonString = new Gson().toJson(category,
                                    new TypeToken<Category>() {
                                    }.getType());

                            result.success(categoryJsonString);
                        }
                    }

                    @Override
                    public void onFailure(Error error) {
                        System.out.println("onFailure -- " + error);
                    }
                });
    }
}
