package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Error;
import com.shopapp.gateway.entity.ProductVariant;
import com.shopapp.shopify.api.ShopifyApi;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GetProductVariantListUseCase extends ShopifyCallUseCase {

    private static final String ARG_PRODUCT_VARIANT_IDS = "productVariantIds";

    public GetProductVariantListUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        List<String> variantIds = input.argument(ARG_PRODUCT_VARIANT_IDS);

        mPluginContext.api.instance.getProductVariantList(variantIds,
                new ApiCallback<List<ProductVariant>>() {

            @Override
            public void onResult(List<ProductVariant> productVariants) {
                if (productVariants != null && productVariants.size() > 0) {
                    String productVariantJson = new Gson().toJson(productVariants,
                            new TypeToken<List<ProductVariant>>() {
                            }.getType());
                    result.success(productVariantJson);
                }
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
                result.error("GetProductVariantListUseCase", error.getMessage(), error);
            }
        });
    }
}
