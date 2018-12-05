import 'package:flutter/material.dart';
import 'package:jvanila_flutter/jvanila.dart';
import 'package:shopify_example/webview_widget.dart';

import 'app.dart';
import 'tow_injector.dart';

class TowApplication extends ApplicationView {

  TowApplication({routes}) : super(routes: routes);

  @override
  Injector newInjector(ApplicationContext context) {
    return new TowInjector(context);
  }

  @override
  void setHomeView() {
    if (widgetTree['home'] == null) {
      widgetTree['home'] = new WebViewExample(context);
    }
    else {
      WebViewExample home = widgetTree['home'];
      home.refresh();
    }
  }

  @override
  loadView(context) {
    return new MaterialApp(
        home: widgetTree["home"], routes: routes,
        theme: ThemeData(primaryColor: Colors.orange));
  }
}