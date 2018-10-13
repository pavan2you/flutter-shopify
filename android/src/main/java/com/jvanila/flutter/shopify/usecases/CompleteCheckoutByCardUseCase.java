package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.plugin.arch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Address;
import com.shopapp.gateway.entity.Checkout;
import com.shopapp.gateway.entity.Error;
import com.shopapp.gateway.entity.Order;
import com.shopapp.gateway.entity.ShippingRate;
import com.shopapp.shopify.api.ShopifyApi;

import java.math.BigDecimal;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class CompleteCheckoutByCardUseCase extends ShopifyCallUseCase {

    private static final String ARG_ADDRESS_JSON = "addressJson";
    private static final String ARG_CHECKOUT_ID = "checkoutId";
    private static final String ARG_CREDIT_CARD_VALUE_TOKEN = "creditCardValueToken";
    private static final String ARG_EMAIL = "email";
    private static final String ARG_WEB_URL = "webUrl";
    private static final String ARG_REQUIRES_SHIPPING = "requiresShipping";
    private static final String ARG_SUBTOTAL_PRICE = "subtotalPrice";
    private static final String ARG_TOTAL_PRICE = "totalPrice";
    private static final String ARG_TAX_PRICE = "taxPrice";
    private static final String ARG_CHECKOUT_CURRENCY = "currency";

    public CompleteCheckoutByCardUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        String token = input.argument(ARG_CREDIT_CARD_VALUE_TOKEN);
        String email = input.argument(ARG_EMAIL);
        String addressJson = input.argument(ARG_ADDRESS_JSON);

        Address address = new Gson().fromJson(addressJson,
                new TypeToken<Address>() {
                }.getType());

        String checkoutId = input.argument(ARG_CHECKOUT_ID);
        String webUrl = input.argument(ARG_WEB_URL);
        boolean requiresShipping = input.argument(ARG_REQUIRES_SHIPPING);
        double subtotalPrice = input.argument(ARG_SUBTOTAL_PRICE);
        double totalPrice = input.argument(ARG_TOTAL_PRICE);
        double taxPrice = input.argument(ARG_TAX_PRICE);
        String currency = input.argument(ARG_CHECKOUT_CURRENCY);

        Checkout checkout = new Checkout(checkoutId, webUrl, requiresShipping,
                new BigDecimal(subtotalPrice), new BigDecimal(totalPrice),
                new BigDecimal(taxPrice), currency, address, new ShippingRate(
                "shippingRate", new BigDecimal(98.9), "handled"));

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
