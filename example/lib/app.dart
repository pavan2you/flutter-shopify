library app;

import 'package:flutter/material.dart';
import 'package:shopify_example/webview_widget.dart';

export 'application.dart';
export 'tow_injector.dart';

routeMap() {
  return <String, WidgetBuilder> {
    '/base': (context) => new WebViewExample(context),
  };
}