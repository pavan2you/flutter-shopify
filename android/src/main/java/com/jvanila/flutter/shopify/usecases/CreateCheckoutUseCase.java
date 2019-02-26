package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.plugin.arch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.CartProduct;
import com.shopapp.gateway.entity.Checkout;
import com.shopapp.gateway.entity.Error;
import com.shopapp.shopify.api.ShopifyApi;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class CreateCheckoutUseCase extends ShopifyCallUseCase {

    private static final String ARG_CART_PRODUCT_JSON = "cartProductJson";

    public CreateCheckoutUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        String cartProductJson = input.argument(ARG_CART_PRODUCT_JSON);

//        String cartProductJson = "[{\"crudOperation\":\"U\",\"productVariant\":{\"crudOperation\":null,\"id\":\"Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0VmFyaWFudC85ODMwODU2MzU5OTgz\",\"title\":\"Default Title\",\"price\":225.0,\"isAvailable\":true,\"selectedOptions\":[{\"crudOperation\":null,\"name\":\"Title\",\"value\":\"Default Title\"}],\"image\":{\"crudOperation\":null,\"id\":\"Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0SW1hZ2UvMzY5Mzg2NDM1MzgzOQ==\",\"src\":\"https://cdn.shopify.com/s/files/1/0020/3633/4639/products/ARYA_ALMONDS_100G_2.JPG?v=1544681584\",\"alt\":null},\"productImage\":{\"crudOperation\":null,\"id\":\"Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0SW1hZ2UvMzY5Mzg2NDM1MzgzOQ==\",\"src\":\"https://cdn.shopify.com/s/files/1/0020/3633/4639/products/ARYA_ALMONDS_100G_2.JPG?v=1544681584\",\"alt\":null},\"productId\":\"Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0LzEwMzk5MzI0ODk3NzU=\"},\"title\":\"ARYA ALMONDS 100G\",\"currency\":\"INR\",\"quantity\":2},{\"crudOperation\":\"U\",\"productVariant\":{\"crudOperation\":null,\"id\":\"Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0VmFyaWFudC85ODE1NjU2MzY2MTI3\",\"title\":\"Default Title\",\"price\":60.0,\"isAvailable\":true,\"selectedOptions\":[{\"crudOperation\":null,\"name\":\"Title\",\"value\":\"Default Title\"}],\"image\":{\"crudOperation\":null,\"id\":\"Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0SW1hZ2UvMzcwMjgwMDk0MTEwMw==\",\"src\":\"https://cdn.shopify.com/s/files/1/0020/3633/4639/products/24LM_RASAM_POWDER_100G_2.JPG?v=1545111864\",\"alt\":null},\"productImage\":{\"crudOperation\":null,\"id\":\"Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0SW1hZ2UvMzcwMjgwMDk0MTEwMw==\",\"src\":\"https://cdn.shopify.com/s/files/1/0020/3633/4639/products/24LM_RASAM_POWDER_100G_2.JPG?v=1545111864\",\"alt\":null},\"productId\":\"Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0LzEwMzM0OTQ2NTkxMTk=\"},\"title\":\"24LM  RASAM POWDER 100G\",\"currency\":\"INR\",\"quantity\":1}]";

        List<CartProduct> cartProducts = new Gson().fromJson(cartProductJson,
                new TypeToken<List<CartProduct>>() {
                }.getType());

        System.out.println("CartProduct -> " + cartProducts);

        mPluginContext.api.instance.createCheckout(cartProducts, new ApiCallback<Checkout>() {
            @Override
            public void onResult(Checkout checkout) {
                if (checkout != null) {

                    String checkoutJsonString = new Gson().toJson(checkout,
                            new TypeToken<Checkout>() {
                            }.getType());

                    result.success(checkoutJsonString);
                }
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
                result.error("CreateCheckoutUseCase", error.getMessage(), error);
            }
        });
    }
}
