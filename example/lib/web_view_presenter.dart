import 'dart:async';

import 'package:jvanila_flutter/jvanila.dart';
import 'package:shopify/domain/initialize_params.dart';
import 'package:shopify/shopify.dart';
import 'package:shopify_example/web_view.dart';
import 'package:shopify/model/customer.dart';

class WebViewPresenter extends Presenter<IWebView> {
  WebViewPresenter(IWebView view) : super(view);

  bool isFirstLoad = true;

  @override
  void onReady() {

    if (isFirstLoad) {
      view.setLoading(isFirstLoad);
      initShopify();
    }
  }

  Future<void> initShopify() async {
    ShopifyInitializeParams params = new ShopifyInitializeParams();
    params.domainName = "porganicworld.myshopify.com";
    params.accessToken = "62761bc137e3dac4c66d1d1a93d8dab3";
    params.apiKey = "1e5f1c6facb67ef0bf9e0c4af642d192";
    params.apiPassword = "5c3061bb2e053642fc1422409ccbb89e";
    await Shopify.initialize(params);

    signIn();
  }

  Future<void> signIn() async {
    await Shopify.signIn("imei355923070770619@gmail.com", "bFppaybqvWaD6CZdAtL5T7FN1XF2");
    String token = await Shopify.getAccessToken();
    view.setAccessToken(token);
    getCustomer();
  }

  Future<void> getCustomer() async {
    Customer customer = await Shopify.getCustomer();
    isFirstLoad = false;
    view.setLoading(isFirstLoad);
    view.setCustomerInfo(customer);
    view.refresh();
  }

}