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
            }
        });
    }
}
