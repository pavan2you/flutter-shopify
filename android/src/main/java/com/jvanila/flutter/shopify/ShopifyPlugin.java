package com.jvanila.flutter.shopify;

import com.jvanila.flutter.pluginarch.Plugin;

import com.jvanila.flutter.pluginarch.PluginContext;
import com.jvanila.flutter.pluginarch.UseCaseProvider;
import com.jvanila.flutter.shopify.usecases.ChangePasswordUseCase;
import com.jvanila.flutter.shopify.usecases.CompleteCheckoutByCardUseCase;
import com.jvanila.flutter.shopify.usecases.CreateCheckoutUseCase;
import com.jvanila.flutter.shopify.usecases.CreateCustomerAddressUseCase;
import com.jvanila.flutter.shopify.usecases.DeleteCustomerAddressUseCase;
import com.jvanila.flutter.shopify.usecases.EditCustomerAddressUseCase;
import com.jvanila.flutter.shopify.usecases.EditCustomerInfoUseCase;
import com.jvanila.flutter.shopify.usecases.ForgotPasswordUseCase;
import com.jvanila.flutter.shopify.usecases.GetAcceptedCardTypesUseCase;
import com.jvanila.flutter.shopify.usecases.GetAccessTokenUseCase;
import com.jvanila.flutter.shopify.usecases.GetArticleListUseCase;
import com.jvanila.flutter.shopify.usecases.GetArticleUseCase;
import com.jvanila.flutter.shopify.usecases.GetCardTokenUseCase;
import com.jvanila.flutter.shopify.usecases.GetCategoryDetailsUseCase;
import com.jvanila.flutter.shopify.usecases.GetCategoryListUseCase;
import com.jvanila.flutter.shopify.usecases.GetCheckoutUseCase;
import com.jvanila.flutter.shopify.usecases.GetCountriesUseCase;
import com.jvanila.flutter.shopify.usecases.GetCustomerUseCase;
import com.jvanila.flutter.shopify.usecases.GetOrderUseCase;
import com.jvanila.flutter.shopify.usecases.GetOrdersUseCase;
import com.jvanila.flutter.shopify.usecases.GetProductListUseCase;
import com.jvanila.flutter.shopify.usecases.GetProductUseCase;
import com.jvanila.flutter.shopify.usecases.GetProductVariantListUseCase;
import com.jvanila.flutter.shopify.usecases.GetShippingRatesUseCase;
import com.jvanila.flutter.shopify.usecases.GetShopInfoUseCase;
import com.jvanila.flutter.shopify.usecases.InitializeUseCase;
import com.jvanila.flutter.shopify.usecases.IsLoggedInUseCase;
import com.jvanila.flutter.shopify.usecases.SearchProductListUseCase;
import com.jvanila.flutter.shopify.usecases.SelectShippingRateUseCase;
import com.jvanila.flutter.shopify.usecases.SetDefaultShippingAddressUseCase;
import com.jvanila.flutter.shopify.usecases.SetShippingAddressUseCase;
import com.jvanila.flutter.shopify.usecases.SignInUseCase;
import com.jvanila.flutter.shopify.usecases.SignOutUseCase;
import com.jvanila.flutter.shopify.usecases.SignUpUseCase;
import com.jvanila.flutter.shopify.usecases.UpdateCustomerSettingsUseCase;
import com.shopapp.shopify.api.ShopifyApi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_CHANGE_PASSWORD;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_COMPLETE_CHECKOUT_BY_CARD;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_CREATE_CHECKOUT;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_CREATE_CUSTOMER_ADDRESS;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_DELETE_CUSTOMER_ADDRESS;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_EDIT_CUSTOMER_ADDRESS;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_EDIT_CUSTOMER_INFO;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_FORGOT_PASSWORD;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_GET_ACCEPTED_CARD_TYPES;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_GET_ACCESS_TOKEN;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_GET_ARTICLE;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_GET_ARTICLE_LIST;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_GET_CARD_TOKEN;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_GET_CATEGORY_DETAILS;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_GET_CATEGORY_LIST;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_GET_CHECKOUT;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_GET_COUNTRIES;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_GET_CUSTOMER;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_GET_ORDER;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_GET_ORDERS;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_GET_PRODUCT;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_GET_PRODUCT_LIST;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_GET_PRODUCT_VARIANT_LIST;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_GET_SHIPPING_RATES;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_GET_SHOP_INFO;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_INITIALIZE;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_IS_LOGGED_IN;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_SEARCH_PRODUCT_LIST;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_SELECT_SHIPPING_RATE;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_SET_DEFAULT_SHIPPING_ADDRESS;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_SET_SHIPPING_ADDRESS;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_SIGN_IN;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_SIGN_OUT;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_SIGN_UP;
import static com.jvanila.flutter.shopify.ShopifyConstants.METHOD_UPDATE_CUSTOMER_SETTINGS;

/**
 * Flutter's Shopify Plugin
 */
public class ShopifyPlugin extends Plugin<ShopifyApi> {

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        new ShopifyPlugin(registrar, "shopify", new Api<>());
    }

    private ShopifyPlugin(Registrar registrar, String name, Api<ShopifyApi> api) {
        super(registrar, name, api);
    }

    @Override
    protected void onCreateUseCases(PluginContext<ShopifyApi> pluginContext,
                                    UseCaseProvider<MethodCall, Result, ShopifyApi> provider) {

        provider.register(METHOD_INITIALIZE, new InitializeUseCase(pluginContext));
        provider.register(METHOD_GET_SHOP_INFO, new GetShopInfoUseCase(pluginContext));

        provider.register(METHOD_GET_CATEGORY_LIST, new GetCategoryListUseCase(pluginContext));
        provider.register(METHOD_GET_CATEGORY_DETAILS,
                new GetCategoryDetailsUseCase(pluginContext));

        provider.register(METHOD_GET_PRODUCT_LIST, new GetProductListUseCase(pluginContext));
        provider.register(METHOD_GET_PRODUCT, new GetProductUseCase(pluginContext));
        provider.register(METHOD_GET_PRODUCT_VARIANT_LIST,
                new GetProductVariantListUseCase(pluginContext));
        provider.register(METHOD_SEARCH_PRODUCT_LIST, new SearchProductListUseCase(pluginContext));

        provider.register(METHOD_GET_ARTICLE_LIST, new GetArticleListUseCase(pluginContext));
        provider.register(METHOD_GET_ARTICLE, new GetArticleUseCase(pluginContext));

        provider.register(METHOD_SIGN_UP, new SignUpUseCase(pluginContext));
        provider.register(METHOD_SIGN_IN, new SignInUseCase(pluginContext));
        provider.register(METHOD_SIGN_OUT, new SignOutUseCase(pluginContext));
        provider.register(METHOD_IS_LOGGED_IN, new IsLoggedInUseCase(pluginContext));
        provider.register(METHOD_GET_ACCESS_TOKEN, new GetAccessTokenUseCase(pluginContext));
        provider.register(METHOD_FORGOT_PASSWORD, new ForgotPasswordUseCase(pluginContext));
        provider.register(METHOD_CHANGE_PASSWORD, new ChangePasswordUseCase(pluginContext));
        provider.register(METHOD_GET_COUNTRIES, new GetCountriesUseCase(pluginContext));

        provider.register(METHOD_GET_CUSTOMER, new GetCustomerUseCase(pluginContext));
        provider.register(METHOD_EDIT_CUSTOMER_INFO, new EditCustomerInfoUseCase(pluginContext));

        provider.register(METHOD_CREATE_CUSTOMER_ADDRESS,
                new CreateCustomerAddressUseCase(pluginContext));
        provider.register(METHOD_EDIT_CUSTOMER_ADDRESS,
                new EditCustomerAddressUseCase(pluginContext));
        provider.register(METHOD_DELETE_CUSTOMER_ADDRESS,
                new DeleteCustomerAddressUseCase(pluginContext));
        provider.register(METHOD_SET_DEFAULT_SHIPPING_ADDRESS,
                new SetDefaultShippingAddressUseCase(pluginContext));
        provider.register(METHOD_UPDATE_CUSTOMER_SETTINGS,
                new UpdateCustomerSettingsUseCase(pluginContext));

        provider.register(METHOD_CREATE_CHECKOUT, new CreateCheckoutUseCase(pluginContext));
        provider.register(METHOD_GET_CHECKOUT, new GetCheckoutUseCase(pluginContext));
        provider.register(METHOD_SET_SHIPPING_ADDRESS,
                new SetShippingAddressUseCase(pluginContext));
        provider.register(METHOD_GET_SHIPPING_RATES, new GetShippingRatesUseCase(pluginContext));
        provider.register(METHOD_SELECT_SHIPPING_RATE,
                new SelectShippingRateUseCase(pluginContext));
        provider.register(METHOD_GET_ACCEPTED_CARD_TYPES,
                new GetAcceptedCardTypesUseCase(pluginContext));
        provider.register(METHOD_GET_CARD_TOKEN, new GetCardTokenUseCase(pluginContext));
        provider.register(METHOD_COMPLETE_CHECKOUT_BY_CARD,
                new CompleteCheckoutByCardUseCase(pluginContext));

        provider.register(METHOD_GET_ORDERS, new GetOrdersUseCase(pluginContext));
        provider.register(METHOD_GET_ORDER, new GetOrderUseCase(pluginContext));
    }
}
