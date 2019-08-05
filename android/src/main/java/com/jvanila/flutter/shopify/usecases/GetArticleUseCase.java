package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Article;
import com.shopapp.gateway.entity.Error;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import kotlin.Pair;

public class GetArticleUseCase extends ShopifyCallUseCase {

    private static final String ARG_ARTICLE_ID = "articleId";

    public GetArticleUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        String articleId = input.argument(ARG_ARTICLE_ID);

        mPluginContext.api.instance.getArticle(articleId, new ApiCallback<Pair<Article, String>>() {
            @Override
            public void onResult(Pair<Article, String> articleStringPair) {
                //TODO test
                if (articleStringPair != null) {
                    String articlesJsonString = new Gson().toJson(articleStringPair,
                            new TypeToken<Article>() {
                            }.getType());
                    result.success(articlesJsonString);
                } else {
                    System.out.println("Article list is empty");
                }
            }

            @Override
            public void onFailure(Error error) {

            }
        });
    }
}
