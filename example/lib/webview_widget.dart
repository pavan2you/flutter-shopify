import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:jvanila_flutter/jvanila.dart';
import 'package:shopify/model/customer.dart';
import 'package:shopify_example/web_view.dart';
import 'package:shopify_example/web_view_presenter.dart';

class WebViewExample extends RefreshableStateWidget {
  final BuildContext context;

  WebViewExample(this.context);

  @override
  createRefreshableState() => _WebViewExampleState(context);
}

class _WebViewExampleState extends PresentableStateView<WebViewExample>
    implements IWebView {
  TextEditingController controller = TextEditingController();
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  var urlString =
      "https://porganicworld.myshopify.com/8316649531/checkouts/0482481819e1a198c11cf7d78e754af5?key=dd406cd3070d1b918a4acd5de66309ea";

  var url1 = "https://porganicworld.myshopify.com/8316649531/checkouts/f22296b6795a5f2d5facc6ec08d63380?key=af945df96b779b4c6fc26d60e68d1022";

  Customer customer;
  WebViewPresenter thisPresenter;
  bool isLoading = true;
  String accessToken;

  Map<String, String> additionalHttpHeaders = new Map();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _WebViewExampleState([BuildContext context]) : super(context);
  launchUrl() {
    setState(() {
      urlString = controller.text;
      flutterWebviewPlugin.reloadUrl(urlString);
    });
  }

  @override
  WebViewPresenter createPresenter() {
    return thisPresenter = new WebViewPresenter(this);
  }

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {
      print(wvs.type);
    });

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print("URL - " + url);
      _scaffoldKey.currentState.showSnackBar(const SnackBar
        (content: const Text('You have Succefully completed placing Order..!')));
    });
  }



  String buildUrl() {
    /*if (customer != null) {
      urlString = urlString +
          "&checkout[email_or_phone]=" +
          customer.email +
          "&checkout[shipping_address][last_name]=" +
          customer.lastName +
          "&checkout[shipping_address][first_name]=" +
          customer.firstName +
          "&checkout[shipping_address][address1]=" +
          customer.defaultAddress.address +
          "&checkout[shipping_address][address2]=" +
          customer.defaultAddress.secondAddress +
          "&checkout[shipping_address][city]=" +
          customer.defaultAddress.city +
          "&checkout[shipping_address][country]=" +
          customer.defaultAddress.country +
          "&checkout[shipping_address][province]=" +
          customer.defaultAddress.state +
          "&checkout[shipping_address][zip]=" +
          customer.defaultAddress.zip;
    }*/
    return urlString;
  }

  Map buildHeaders() {
    if (accessToken != null) {
      additionalHttpHeaders['X-Shopify-Customer-Access-Token'] = accessToken;
    }
    return additionalHttpHeaders;
  }

  @override
  Widget loadView(BuildContext context) {
    if (isLoading) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return WebviewScaffold(
        appBar: AppBar(
          title: new Text("Welcome"),
        ),
        url: buildUrl(),
        withZoom: false,
        headers: buildHeaders(),

      );
    }
  }

  @override
  void setCustomerInfo(Customer customer) {
    this.customer = customer;
  }

  @override
  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  @override
  void setAccessToken(String token) {
    this.accessToken = token;
  }

}
