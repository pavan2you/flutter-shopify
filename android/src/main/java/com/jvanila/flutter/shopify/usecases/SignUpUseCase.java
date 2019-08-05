package com.jvanila.flutter.shopify.usecases;

import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Error;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import kotlin.Unit;

public class SignUpUseCase extends ShopifyCallUseCase {

    private static final String ARG_FIRST_NAME = "firstName";
    private static final String ARG_LAST_NAME = "lastName";
    private static final String ARG_EMAIL = "email";
    private static final String ARG_PASSWORD = "password";
    private static final String ARG_PHONE = "phone";

    public SignUpUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        String firstName = input.argument(ARG_FIRST_NAME);
        String lastName = input.argument(ARG_LAST_NAME);
        final String email = input.argument(ARG_EMAIL);
        String password = input.argument(ARG_PASSWORD);
        String phone = input.argument(ARG_PHONE);

        mPluginContext.api.instance.signUp(firstName, lastName, email, password, phone, new ApiCallback<Unit>() {
            @Override
            public void onResult(Unit unit) {
                result.success("success");
            }

            @Override
            public void onFailure(Error error) {
                //Customer accounts not allowed
                System.out.println("onFailure -- " + error);
//                result.success(error.getMessage());
//                result.error("SignUpUseCase.onFailure", "", error);
                result.error("SignUpUseCase", error.getMessage(), error);
            }
        });
    }
}
