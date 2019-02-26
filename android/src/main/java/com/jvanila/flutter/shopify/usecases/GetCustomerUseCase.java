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

public class GetCustomerUseCase extends ShopifyCallUseCase {

    public GetCustomerUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        mPluginContext.api.instance.getCustomer(new ApiCallback<Customer>() {
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
                //Unauthorised
//                result.success("onFailure -- " + error);

                result.error("GetCustomerUseCase", error.getMessage(), error);
                System.out.println("onFailure -- " + error);
            }
        });
    }
}
