package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Address;
import com.shopapp.gateway.entity.Checkout;
import com.shopapp.gateway.entity.Error;
import com.shopapp.gateway.entity.Order;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class CompleteCheckoutByCardUseCase extends ShopifyCallUseCase {

    private static final String ARG_ADDRESS_JSON = "addressJson";
    private static final String ARG_CHECKOUT_JSON = "checkoutJson";
    private static final String ARG_CREDIT_CARD_VALUE_TOKEN = "creditCardValueToken";
    private static final String ARG_EMAIL = "email";

    public CompleteCheckoutByCardUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        String token = input.argument(ARG_CREDIT_CARD_VALUE_TOKEN);
        String email = input.argument(ARG_EMAIL);
        String addressJson = input.argument(ARG_ADDRESS_JSON);
        String checkoutJson = input.argument(ARG_CHECKOUT_JSON);

        Address address = new Gson().fromJson(addressJson,
                new TypeToken<Address>() {
                }.getType());

        Checkout checkout = new Gson().fromJson(checkoutJson,
                new TypeToken<Checkout>() {
                }.getType());

        mPluginContext.api.instance.completeCheckoutByCard(checkout, email, address, token,
                new ApiCallback<Order>() {
                    @Override
                    public void onResult(Order order) {
                        if (order != null) {

                            String orderJsonString = new Gson().toJson(order,
                                    new TypeToken<Order>() {
                                    }.getType());

                            result.success(orderJsonString);
                        }
                    }

                    @Override
                    public void onFailure(Error error) {
                        System.out.println("onFailure -- " + error);
                    }
                });
    }
}
