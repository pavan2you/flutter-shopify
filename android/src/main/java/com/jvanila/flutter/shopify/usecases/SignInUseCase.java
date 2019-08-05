package com.jvanila.flutter.shopify.usecases;

import android.os.Handler;

import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Error;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import kotlin.Unit;

public class SignInUseCase extends ShopifyCallUseCase {

    private static final String ARG_EMAIL = "email";
    private static final String ARG_PASSWORD = "password";

    public SignInUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        final String email = input.argument(ARG_EMAIL);
        final String password = input.argument(ARG_PASSWORD);

        Handler handler = new Handler();
        handler.post(new Runnable() {
            @Override
            public void run() {
/*
            mApi.signIn(email, password, new ApiCallback<Unit>() {
                @Override
                public void onResult(Unit unit) {
                    result.success(unit);
                }

                @Override
                public void onFailure(Error error) {
                    System.out.println("onFailure -- " + error);
                }
            });
*/
            }
        });

        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                mPluginContext.api.instance.signIn(email, password, new ApiCallback<Unit>() {
                    @Override
                    public void onResult(Unit unit) {
                        result.success(true);
                    }

                    @Override
                    public void onFailure(Error error) {
//                        result.success(false);
                        System.out.println("onFailure -- " + error);
                        result.error("SignInUseCase", error.getMessage(), error);
                    }
                });
            }
        });
        thread.start();
    }
}
