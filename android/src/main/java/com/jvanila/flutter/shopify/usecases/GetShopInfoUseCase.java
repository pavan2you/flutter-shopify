package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Error;
import com.shopapp.gateway.entity.Shop;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
/**
 * Created by pragna on 24/09/18
 */
public class GetShopInfoUseCase extends ShopifyCallUseCase {

    public GetShopInfoUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        mPluginContext.api.instance.getShopInfo(new ApiCallback<Shop>() {
            @Override
            public void onResult(Shop shop) {
                if (shop != null) {

                    String shopJsonString = new Gson().toJson(shop,
                            new TypeToken<Shop>() {
                            }.getType());

                    result.success(shopJsonString);
                }
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
                result.error("GetShopInfoUseCase", error.getMessage(), error);
            }
        });
    }
}
