package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Article;
import com.shopapp.gateway.entity.Error;
import com.shopapp.gateway.entity.SortType;
import com.shopapp.shopify.api.ShopifyApi;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GetArticleListUseCase extends ShopifyCallUseCase {
    private static final String ARG_PER_PAGE = "perPage";
    private static final String ARG_PAGINATION_VALUE = "paginationValue";
    private static final String ARG_SORT_BY = "sortBy";
    private static final String ARG_REVERSE = "reverse";

    public GetArticleListUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        int perPage = input.argument(ARG_PER_PAGE);
        Object paginationValue = input.argument(ARG_PAGINATION_VALUE);
        SortType sortBy = input.argument(ARG_SORT_BY);
        Boolean reverse = input.argument(ARG_REVERSE);

        mPluginContext.api.instance.getArticleList(perPage, paginationValue, sortBy, reverse,
                new ApiCallback<List<Article>>() {
                    @Override
                    public void onResult(List<Article> articles) {
                        if (articles != null && articles.size() > 0) {
                            String articlesJsonString = new Gson().toJson(articles,
                                    new TypeToken<List<Article>>() {
                                    }.getType());
                            result.success(articlesJsonString);
                        } else {
                            System.out.println("Article list is empty");
                        }
                    }

                    @Override
                    public void onFailure(Error error) {
                        System.out.println("onFailure -- " + error);
                    }
                });
    }
}
