package com.jvanila.flutter.shopify.usecases;

import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Address;
import com.shopapp.gateway.entity.Error;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import kotlin.Unit;

public class EditCustomerAddressUseCase extends ShopifyCallUseCase {

    private static final String ARG_ADDRESS_ID = "addressId";
    private static final String ARG_PRIMARY_ADDRESS = "primaryAddress";
    private static final String ARG_SECOND_ADDRESS = "secondAddress";
    private static final String ARG_CITY = "city";
    private static final String ARG_STATE = "state";
    private static final String ARG_COUNTRY = "country";
    private static final String ARG_ZIP = "zip";
    private static final String ARG_FIRST_NAME = "firstName";
    private static final String ARG_LAST_NAME = "lastName";
    private static final String ARG_COMPANY = "company";
    private static final String ARG_PHONE = "phone";

    public EditCustomerAddressUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
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

        Address address = new Address(id, primaryAddress, secondAddress, city, country,
                state, firstName, lastName, zip, company, phone);

        mPluginContext.api.instance.editCustomerAddress(id, address, new ApiCallback<Unit>() {
            @Override
            public void onResult(Unit unit) {
                result.success(true);
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
                result.error("EditCustomerAddressUseCase", error.getMessage(), error);
            }
        });
    }
}
