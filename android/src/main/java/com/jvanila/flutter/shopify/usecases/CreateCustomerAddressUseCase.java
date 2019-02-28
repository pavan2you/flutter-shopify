package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.plugin.arch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Address;
import com.shopapp.gateway.entity.Error;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class CreateCustomerAddressUseCase extends ShopifyCallUseCase {

    private static final String ARG_ADDRESS_JSON = "addressJson";

    public CreateCustomerAddressUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {

        String addressJson = input.argument(ARG_ADDRESS_JSON);

        Address addr = new Gson().fromJson(addressJson,
                new TypeToken<Address>() {
                }.getType());

        mPluginContext.api.instance.createCustomerAddress(addr, new ApiCallback<String>() {
            @Override
            public void onResult(String addressId) {
                result.success(addressId);
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
                result.error("CreateCustomerAddressUseCase", error.getMessage(), error);
            }
        });
    }
}
