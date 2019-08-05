package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.CardType;
import com.shopapp.gateway.entity.Error;
import com.shopapp.shopify.api.ShopifyApi;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GetAcceptedCardTypesUseCase extends ShopifyCallUseCase {

    public GetAcceptedCardTypesUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        mPluginContext.api.instance.getAcceptedCardTypes(new ApiCallback<List<? extends CardType>>() {
            @Override
            public void onResult(List<? extends CardType> cardTypes) {
                if (cardTypes != null && cardTypes.size() > 0) {

                    String cardTypesJsonString = new Gson().toJson(cardTypes,
                            new TypeToken<List<CardType>>() {
                            }.getType());

                    result.success(cardTypesJsonString);
                } else {
                    System.out.println("No available Card Types.");
                }
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
            }
        });
    }
}
