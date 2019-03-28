package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.plugin.arch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Customer;
import com.shopapp.gateway.entity.Error;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class EditCustomerInfoUseCase extends ShopifyCallUseCase {

    private static final String ARG_FIRST_NAME = "firstName";
    private static final String ARG_LAST_NAME = "lastName";
    private static final String ARG_PHONE = "phone";
    private static final String ARG_EMAIL = "email";


    public EditCustomerInfoUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        String firstName = input.argument(ARG_FIRST_NAME);
        String lastName = input.argument(ARG_LAST_NAME);
        String phone = input.argument(ARG_PHONE);
        String email = input.argument(ARG_EMAIL);

        mPluginContext.api.instance.editCustomerInfo(firstName, lastName, phone, email,
                new ApiCallback<Customer>() {
            @Override
            public void onResult(Customer customer) {
                if (customer != null) {

                    String customerJsonString = new Gson().toJson(customer,
                            new TypeToken<Customer>() {
                            }.getType());

                    result.success(customerJsonString);
                }
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
                result.error("EditCustomerInfoUseCase", error.getMessage(), error);
            }
        });
    }
}
