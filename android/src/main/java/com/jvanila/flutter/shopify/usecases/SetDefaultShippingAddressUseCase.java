package com.jvanila.flutter.shopify.usecases;

import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Error;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import kotlin.Unit;

public class SetDefaultShippingAddressUseCase extends ShopifyCallUseCase {

    private static final String ARG_ADDRESS_ID = "addressId";

    public SetDefaultShippingAddressUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        String addressId = input.argument(ARG_ADDRESS_ID);
        mPluginContext.api.instance.setDefaultShippingAddress(addressId, new ApiCallback<Unit>() {
            @Override
            public void onResult(Unit unit) {
                result.success(true);
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
//                result.success(false);
                result.error("SetDefaultShippingAddressUseCase", error.getMessage(), error);
            }
        });
    }
}
