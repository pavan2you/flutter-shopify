package com.jvanila.flutter.shopify.usecases;

import com.jvanila.flutter.pluginarch.PluginContext;
import com.shopapp.gateway.ApiCallback;
import com.shopapp.gateway.entity.Card;
import com.shopapp.gateway.entity.Error;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GetCardTokenUseCase extends ShopifyCallUseCase {

    private static final String ARG_CARD_FIRST_NAME = "firstName";
    private static final String ARG_CARD_LAST_NAME = "lastName";
    private static final String ARG_CARD_NUMBER = "cardNumber";
    private static final String ARG_CARD_EXPIRE_MONTH = "expireMonth";
    private static final String ARG_CARD_EXPIRE_YEAR = "expireYear";
    private static final String ARG_CARD_VERIFICATION_CODE = "verificationCode";

    public GetCardTokenUseCase(PluginContext<ShopifyApi> pluginContext) {
        super(pluginContext);
    }

    @Override
    protected void call(MethodCall input, final MethodChannel.Result result) {
        String firstName = input.argument(ARG_CARD_FIRST_NAME);
        String lastName = input.argument(ARG_CARD_LAST_NAME);
        String cardNumber = input.argument(ARG_CARD_NUMBER);
        String expireMonth = input.argument(ARG_CARD_EXPIRE_MONTH);
        String expireYear = input.argument(ARG_CARD_EXPIRE_YEAR);
        String verificationCode = input.argument(ARG_CARD_VERIFICATION_CODE);

        Card card = new Card(firstName, lastName, cardNumber, expireMonth,
                expireYear, verificationCode);

        mPluginContext.api.instance.getCardToken(card, new ApiCallback<String>() {
            @Override
            public void onResult(String s) {
                result.success(s);
            }

            @Override
            public void onFailure(Error error) {
                System.out.println("onFailure -- " + error);
            }
        });
    }
}
