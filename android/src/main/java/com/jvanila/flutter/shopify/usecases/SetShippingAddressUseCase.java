package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.plugin.arch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Address;
import com.shopapp.gateway.entity.Checkout;
import com.shopapp.gateway.entity.Error;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class SetShippingAddressUseCase extends ShopifyCallUseCase {

    private static final String ARG_CHECKOUT_ID = "checkoutId";
    private static final String ARG_PRIMARY_ADDRESS = "primaryAddress";
    private static final String ARG_SECOND_ADDRESS = "secondAddress";
    private static final String ARG_CITY = "city";
    private static final String ARG_STATE = "state";
    private static final String ARG_COUNTRY = "country";
    private static final String ARG_ZIP = "zip";
    private static final String ARG_COMPANY = "company";
    private static final String ARG_ADDRESS_ID = "addressId";
    private static final String ARG_FIRST_NAME = "firstName";
    private static final String ARG_LAST_NAME = "lastName";
    private static final String ARG_PHONE = "phone";

    public SetShippingAddressUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        String checkoutId = input.argument(ARG_CHECKOUT_ID);
        String id = input.argument(ARG_ADDRESS_ID);
        String primaryAddress = input.argument(ARG_PRIMARY_ADDRESS);
        String secondAddress = input.argument(ARG_SECOND_ADDRESS);
        String city = input.argument(ARG_CITY);
        String state = input.argument(ARG_STATE);
        String country = input.argument(ARG_COUNTRY);
        String firstName = input.argument(ARG_FIRST_NAME);
        String lastName = input.argument(ARG_LAST_NAME);
        String zip = input.argument(ARG_ZIP);
        String company = input.argument(ARG_COMPANY);
        String phone = input.argument(ARG_PHONE);

        Address address = new Address(id, primaryAddress, secondAddress, city, state,
                country, firstName, lastName, zip, company, phone);

        mPluginContext.api.instance.setShippingAddress(checkoutId, address, new ApiCallback<Checkout>() {
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
                result.error("SetShippingAddressUseCase", error.getMessage(), error);
            }
        });
    }
}
