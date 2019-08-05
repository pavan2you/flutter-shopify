package com.jvanila.flutter.shopify.usecases;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Country;
import com.shopapp.gateway.entity.Error;
import com.shopapp.shopify.api.ShopifyApi;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GetCountriesUseCase extends ShopifyCallUseCase {

    public GetCountriesUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        mPluginContext.api.instance.getCountries(new ApiCallback<List<Country>>() {
            @Override
            public void onResult(List<Country> countries) {
                if (countries != null && countries.size() > 0) {

                    String countriesJsonString = new Gson().toJson(countries,
                            new TypeToken<List<Country>>() {
                            }.getType());

                    result.success(countriesJsonString);
                }
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
                result.error("GetCountriesUseCase", error.getMessage(), error);
            }
        });
    }
}
