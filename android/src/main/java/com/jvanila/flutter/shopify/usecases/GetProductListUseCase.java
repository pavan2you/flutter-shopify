package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Error;
import com.shopapp.gateway.entity.Product;
import com.shopapp.gateway.entity.SortType;
import com.shopapp.shopify.api.ShopifyApi;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * Created by pragna on 23/09/18
 */
public class GetProductListUseCase extends ShopifyCallUseCase {

    private static final String ARG_PER_PAGE = "perPage";
    private static final String ARG_PAGINATION_VALUE = "paginationValue";
    private static final String ARG_SORT_BY = "sortBy";
    private static final String ARG_KEYWORD = "keyword";
    private static final String ARG_EXCLUDE_KEYWORD = "excludeKeyword";

    public GetProductListUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {

        int perPage = input.argument(ARG_PER_PAGE);
        Object paginationValue = input.argument(ARG_PAGINATION_VALUE);

        String keyword = input.argument(ARG_KEYWORD);
        String excludeKeyword = input.argument(ARG_EXCLUDE_KEYWORD);

        int sortByIndex = input.argument(ARG_SORT_BY);
        SortType sortBy = getSortByValue(sortByIndex);

        mPluginContext.api.instance.getProductList(perPage, paginationValue, sortBy,
                keyword, excludeKeyword, new ApiCallback<List<Product>>() {

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
                        result.error("GetProductListUseCase", error.getMessage(), error);
                    }
                });
    }

    private SortType getSortByValue(int sortByIndex) {
        switch(sortByIndex) {
            case 1:
                return SortType.NAME;
            case 2:
                return SortType.RECENT;
            case 3:
                return SortType.RELEVANT;
            case 4:
                return SortType.PRICE_HIGH_TO_LOW;
            case 5:
                return SortType.PRICE_LOW_TO_HIGH;
            default:
                return SortType.NAME;
        }
    }
}
