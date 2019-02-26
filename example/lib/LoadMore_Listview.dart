import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:shopify/shopify.dart';
import 'package:shopify/model/product.dart';
import 'package:shopify/domain/initialize_params.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int get count => list.length;
  int index = 0;
  bool _isFinish = false;

  List<Product> list = [];

  void initState() {
    super.initState();
    // list.addAll(List.generate(30, (v) => v));
    initShopify();
  }

  Future<void>  initShopify() async {
    ShopifyInitializeParams params = new ShopifyInitializeParams();
    params.domainName = "porganicworld.myshopify.com";
    params.accessToken = "62761bc137e3dac4c66d1d1a93d8dab3";
    params.apiKey = "1e5f1c6facb67ef0bf9e0c4af642d192";
    params.apiPassword = "5c3061bb2e053642fc1422409ccbb89e";
    await Shopify.initialize(params);
    bool val = await Shopify.signIn("test@gmail.com", "test123456");

    print('Result - $val');
  }

  void load(List<Product> listItems) {
    print("load");
    setState(() {
      list.addAll(listItems);//List.generate(15, (v) => v));
      print("data count = ${list.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: RefreshIndicator(
          child: LoadMore(
            isFinish: _isFinish,//count >= 60,
            onLoadMore: _loadMore,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Text(list[index].title),
                  height: 40.0,
                  alignment: Alignment.center,
                );
              },
              itemCount: count,
            ),
            whenEmptyLoad: false,
            delegate: DefaultLoadMoreDelegate(),
            textBuilder: DefaultLoadMoreTextBuilder.english,
          ),
          onRefresh: _refresh,
        ),
      ),
    );
  }

  static Future<List> getShopify(paginationValue) async {
    await Future.delayed(Duration(seconds: 1));
    List<Product> list = await Shopify.getProductList(10, paginationValue, null, null, null);
    return list;
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    index++;
    //await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    String paginationValue = null;

    if(list != null && list.length >= index && list.isNotEmpty){
      paginationValue = list[list.length - 1].paginationValue;
    }

    List prodcutsList =  await Shopify.getProductList(10, paginationValue, null, null, null);
    if(prodcutsList.isNotEmpty)
      load(prodcutsList);
    else
      _isFinish = true;
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    index = 0;
    list.clear();
    List prodcutsList =  await Shopify.getProductList(10, null, null, null, null);
    if(prodcutsList.isNotEmpty)
      load(prodcutsList);
  }
}
