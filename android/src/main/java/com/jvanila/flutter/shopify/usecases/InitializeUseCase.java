package com.jvanila.flutter.shopify.usecases;


import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import static com.shopapp.shopify.constant.Constant.DEFAULT_SCHEME;

/**
 * Created by pavan on 22/09/18
 */
public class InitializeUseCase extends ShopifyCallUseCase {

    private static final String ARG_BASE_DOMAIN = "baseDomain";
    private static final String ARG_STORE_FRONT_ACCESS_TOKEN = "storeFrontAccessToken";
    private static final String ARG_API_KEY = "apiKey";
    private static final String ARG_API_PASSWORD = "apiPassword";

    public InitializeUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, MethodChannel.Result result) {
        String baseDomain = input.argument(ARG_BASE_DOMAIN);
        String storeFrontAccessToken = input.argument(ARG_STORE_FRONT_ACCESS_TOKEN);
        String apiKey = input.argument(ARG_API_KEY);
        String apiPassword = input.argument(ARG_API_PASSWORD);

        mPluginContext.api.instance = new ShopifyApi(mPluginContext.plugin.getRegistrar().context(),
                baseDomain, storeFrontAccessToken, apiKey, apiPassword, DEFAULT_SCHEME);

        System.out.println("mApi initialized " + mPluginContext.api.instance.toString());

        result.success("mApi initialized " + mPluginContext.api.toString());
    }
}
