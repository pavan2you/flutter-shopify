package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Error;
import com.shopapp.gateway.entity.Product;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * Created by pragna on 24/09/18
 */
public class GetProductUseCase extends ShopifyCallUseCase {

    private static final String ARG_PRODUCT_ID = "productId";

    public GetProductUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {

        String productId = input.argument(ARG_PRODUCT_ID);

        mPluginContext.api.instance.getProduct(productId, new ApiCallback<Product>() {
            @Override
            public void onResult(Product product) {
                if (product != null) {

                    String productJsonString = new Gson().toJson(product,
                            new TypeToken<Product>() {
                            }.getType());

                    result.success(productJsonString);
                }
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
                result.error("GetProductUseCase", error.getMessage(), error);
            }
        });
    }
}
