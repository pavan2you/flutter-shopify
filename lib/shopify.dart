import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shopify/domain/initialize_params.dart';
import 'package:shopify/model/address.dart';
import 'package:shopify/model/article.dart';
import 'package:shopify/model/card.dart';
import 'package:shopify/model/card_type.dart';
import 'package:shopify/model/cart_product.dart';
import 'package:shopify/model/category.dart';
import 'package:shopify/model/checkout.dart';
import 'package:shopify/model/country.dart';
import 'package:shopify/model/customer.dart';
import 'package:shopify/model/order.dart';
import 'package:shopify/model/product.dart';
import 'package:shopify/model/product_variant.dart';
import 'package:shopify/model/shipping_rate.dart';
import 'package:shopify/model/shop.dart';
import 'package:shopify/model/sort_type.dart';

import 'shopify_constants.dart';

class Shopify {

  static const MethodChannel _channel = const MethodChannel(kChannelIdentifier);

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }


  //////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////  INITIALIZE  ///////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  static Future<String> initialize(ShopifyInitializeParams params) async {

    Map<dynamic, dynamic> args = new Map();
    args[kArgBaseDomain] = params.domainName;
    args[kArgStorefrontAccessToken] = params.accessToken;
    args[kArgApiKey] = params.apiKey;
    args[kArgApiPassword] = params.apiPassword;

    return await _channel.invokeMethod(kMethodInitialize, args);
  }


  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////  PRODUCTS  ////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  static Future<List<Product>> getProductList(int perPage,
      dynamic paginationValue, String keyword, String excludeKeyword,
      SortType sortBy) async {

    Map<dynamic, dynamic> args = new Map();
    args[kArgPerPage] = perPage;
    args[kArgPaginationValue] = paginationValue;

    args[kArgKeyword] = keyword;
    args[kArgExcludeKeyword] = excludeKeyword;

    int sortByJson = sortBy.index;
    args[kArgSortBy] = sortByJson;

    final String responseJson = await _channel.invokeMethod(
      kMethodGetProductList, args);
    final responseMap = json.decode(responseJson).cast<Map<String, dynamic>>();
    final response = responseMap.map<Product>((json) => Product.fromJson(json))
      .toList();

    return response;
  }

  static Future<List<ProductVariant>> getProductVariantList(
      List<String> productVariantIds) async {

    Map<dynamic, dynamic> args = new Map();
    args[kArgProductVariantIds] = productVariantIds;

    final String responseJson = await _channel.invokeMethod(
      kMethodGetProductVariantList, args);
    final responseMap = json.decode(responseJson).cast<Map<String, dynamic>>();
    var compareToPrice = responseMap['compareToPrice'];
    if (compareToPrice == null) {
      responseMap['compareToPrice'] = 0.0;
    }
    final List<ProductVariant> response = responseMap.map<ProductVariant>((
        json) => ProductVariant.fromJson(json)).toList();

    return response;
  }

  static Future<List<Product>> searchProductList(String searchQuery,
      int perPage, dynamic paginationValue) async {

    Map<dynamic, dynamic> args = new Map();
    args[kArgQuery] = searchQuery;
    args[kArgPerPage] = perPage;
    args[kArgPaginationValue] = paginationValue;

    List<Product> response;

    await _channel.invokeMethod(
      kMethodSearchProductList, args).then((value) {
      final responseMap = json.decode(value).cast<Map<String, dynamic>>();
      response = responseMap.map<Product>((json) =>
          Product.fromJson(json),).toList();
    }).catchError((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });

    return response;
  }

  static Future<Product> getProduct(String id) async {
    Map<dynamic, dynamic> args = new Map();
    args[kArgProductId] = id;

    final String responseJson = await _channel.invokeMethod(kMethodGetProduct,
        args);
    final responseMap = json.decode(responseJson);
    final Product response = Product.fromJson(responseMap);

    return response;
  }


  //////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////  CATEGORIES  ///////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  static Future<List<Category>> getCategoryList(int perPage,
      dynamic paginationValue) async {

    Map<dynamic, dynamic> args = new Map();
    args[kArgPerPage] = perPage;
    args[kArgPaginationValue] = paginationValue;

    List<Category> response;

    await _channel.invokeMethod(
      kMethodGetCategoryList, args,).then((value) {
      final responseMap = json.decode(value).cast<Map<String, dynamic>>();

      response = responseMap.map<Category>((json) =>
          getCategory(json),).toList();

      if (response == null) {
        response = new List();
      }
    }).catchError((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });

    return response;
  }

  static Category getCategory(json) {
    var image = json['image'];
    if (image == null) {
      json['image'] = new Map<String, dynamic>();
    }
    return Category.fromJson(json);
  }

  static Future<Category> getCategoryDetails(String id, int perPage,
      dynamic paginationValue, SortType sortBy) async {

    Map<dynamic, dynamic> args = new Map();
    args[kArgCategoryId] = id;
    args[kArgPerPage] = perPage;
    args[kArgPaginationValue] = paginationValue;

    int sortByJson = sortBy.index;

    args[kArgSortBy] = sortByJson;

    Category response;

    await _channel.invokeMethod(
      kMethodGetCategoryDetails, args,).then((value) {
      final responseMap = json.decode(value);
      var image = responseMap['image'];
      if (image == null) {
        responseMap['image'] = new Map<String, dynamic>();
      }
      response = Category.fromJson(responseMap);
    }).catchError((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });


    return response;
  }


  //////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////  SHOP INFO  ////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  static Future<Shop> getShopInfo() async {
    final String responseJson = await _channel.invokeMethod(kMethodGetShopInfo);
    final responseMap = json.decode(responseJson);
    final Shop response = Shop.fromJson(responseMap);

    return response;
  }


  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////  ARTICLES  ////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  static Future<List<Article>> getArticleList(int perPage,
      dynamic paginationValue, SortType sortBy, bool reverse) async {

    Map<dynamic, dynamic> args = new Map();
    args[kArgPerPage] = perPage;
    args[kArgPaginationValue] = paginationValue;
    args[kArgSortBy] = sortBy;
    args[kArgReverse] = reverse;

    final String responseJson = await _channel.invokeMethod(
        kMethodGetArticleList, args);

    final responseMap = json.decode(responseJson).cast<Map<String, dynamic>>();
    List<Article> response = responseMap.map<Article>((json) =>
        Article.fromJson(json),).toList();

    return response;
  }

  static Future<Article> getArticle(String id) async {
    Map<dynamic, dynamic> args = new Map();
    args[kArgArticleId] = id;

    final String responseJson = await _channel.invokeMethod(
        kMethodGetArticleList, args);
    final responseMap = json.decode(responseJson);
    final Article response = Article.fromJson(responseMap);

    return response;
  }


  //////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////  ONBOARDING  ///////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  static Future<String> signUp(String firstName, String lastName, String email,
      String password, String phone) async {

    Map<dynamic, dynamic> args = new Map();
    args[kArgFirstName] = firstName;
    args[kArgLastName] = lastName;
    args[kArgEmail] = email;
    args[kArgPassword] = password;
    args[kArgPhone] = phone;

    String response;
    await _channel.invokeMethod(kMethodSignUp, args).then((value) {
      response = value;
    }).catchError((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });
    return response;
  }

  static Future<bool> signIn(String email, String password) async {
    Map<dynamic, dynamic> args = new Map();
    args[kArgEmail] = email;
    args[kArgPassword] = password;

    bool response;
    await _channel.invokeMethod(kMethodSignIn, args).then((value) {
      response = value;
    }).catchError((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });

    return response;
  }

  static Future<String> getAccessToken() async {
    String response;
    await _channel.invokeMethod(kMethodGetAccessToken).then((value) {
      response = value;
    }).catchError((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });
    return response;
  }

  static Future<bool> signOut() async {
    bool response;
    await _channel.invokeMethod(kMethodSignOut).then((value) {
      response = value;
    }).catchError((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });;
    return response;
  }

  static Future<bool> isLoggedIn() async {
    bool response;
    await _channel.invokeMethod(kMethodIsLoggedIn).then((value) {
      response = value;
    }).catchError((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });;
    return response;
  }

  static Future<bool> forgotPassword(String email) async {
    Map<dynamic, dynamic> args = new Map();
    args[kArgEmail] = email;

    bool response;
    await _channel.invokeMethod(
      kMethodForgotPassword, args,).then((value) {
      response = value;
    }).catchError((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });
    return response;
  }

  static Future<bool> changePassword(String password) async {
    Map<dynamic, dynamic> args = new Map();
    args[kArgPassword] = password;

    bool response;
    await _channel.invokeMethod(
      kMethodChangePassword, args,).then((value) {
      response = value;
    }).catchError((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });
    return response;
  }


  //////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////  COUNTRIES  ////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  static Future<List<Country>> getCountries() async {
    final String responseJson = await _channel.invokeMethod(
      kMethodGetCountries,);

    final responseMap = json.decode(responseJson).cast<Map<String, dynamic>>();
    List<Country> response = responseMap.map<Country>((json) =>
        Country.fromJson(json),).toList();

    return response;
  }


  //////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////  CUSTOMER  /////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  static Future<Customer> getCustomer() async {
    Customer response;
    await _channel.invokeMethod(kMethodGetCustomer).then((value) {
      final responseMap = json.decode(value);
      //dirty fix to avoid null pointer.
      var address = responseMap['defaultAddress'];
      if (address == null) {
        responseMap['defaultAddress'] = new Map<String, dynamic>();
      }
      response = Customer.fromJson(responseMap);
    }).catchError((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });
    return response;
  }

  static Future<bool> setDefaultShippingAddress(String addressId) async {
    Map<dynamic, dynamic> args = new Map();
    args[kArgAddressId] = addressId;

    bool response;
    await _channel.invokeMethod(
      kMethodSetDefaultShippingAddress, args,).then((value) {
      response = value;
    }).catchError((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });

    return response;
  }

  static Future<String> createCustomerAddress(Address address) async {
    Map<dynamic, dynamic> args = new Map();
    String addressJson = json.encode(address);
    args[kArgAddressJson] = addressJson;

    String response;
    await _channel.invokeMethod(kMethodCreateCustomerAddress, args).then((value) {
      response = value;
    }).catchError((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });

    return response;
  }

  static Future<bool> editCustomerAddress(String addressId, Address address)
    async {

    Map<dynamic, dynamic> args = new Map();
    args[kArgAddressId] = addressId;
    args[kArgPrimaryAddress] = address.address;
    args[kArgSecondAddress] = address.secondAddress;
    args[kArgCity] = address.city;
    args[kArgState] = address.state;
    args[kArgCountry] = address.country;
    args[kArgFirstName] = address.firstName;
    args[kArgLastName] = address.lastName;
    args[kArgZip] = address.zip;
    args[kArgCompany] = address.company;
    args[kArgPhone] = address.phone;

    bool response;
    await _channel.invokeMethod(kMethodEditCustomerAddress, args,).then((value) {
      response = value;
    }).catchError((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });

    return response;
  }

  static Future<bool> deleteCustomerAddress(String addressId) async {
    Map<dynamic, dynamic> args = new Map();
    args[kArgAddressId] = addressId;

    bool response;
    await _channel.invokeMethod(kMethodDeleteCustomerAddress, args,).then((value) {
      response = value;
    }).catchError((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });

    return response;
  }

  static Future<Customer> editCustomerInfo(String firstName, String lastName,
      String phone, String email) async {

    Map<dynamic, dynamic> args = new Map();
    args[kArgFirstName] = firstName;
    args[kArgLastName] = lastName;
    args[kArgPhone] = phone;
    args[kArgEmail] = email;

    Customer response;

    await _channel.invokeMethod(
      kMethodEditCustomerInfo, args,)
        .then((value){
      print("Response Value : ${value}");

      final responseMap = json.decode(value);
      var address = responseMap['defaultAddress'];
      if (address == null) {
        responseMap['defaultAddress'] = new Map<String, dynamic>();
      }
      response = Customer.fromJson(responseMap);
    }) // Future completes with two()'s error.
        .catchError((e) {
      print("Got error: ${e.code}"); // Finally, callback fires.
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });

    return response;
  }

  static Future<bool> updateCustomerSettings(bool isAcceptMarketing) async {
    Map<dynamic, dynamic> args = new Map();
    args[kArgIsAcceptMarketing] = isAcceptMarketing;

    bool response;
    await _channel.invokeMethod(kMethodUpdateCustomerSettings, args,).then((value) {
      response = value;
    }).catchError((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });

    return response;
  }


  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////  CHECKOUT  ///////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  static Future<Checkout> createCheckout(List<CartProduct> cartProductList)
    async {

    Map<dynamic, dynamic> args = new Map();
    String cartProductJson = json.encode(cartProductList);
    args[kCartProductJson] = cartProductJson;

    Checkout response;
    await _channel.invokeMethod(
      kMethodCreateCheckout, args,).then((value) {
      final responseMap = json.decode(value);
      response = Checkout.fromJson(responseMap);
    }).catchError((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });

    return response;
  }

  static Future<Checkout> getCheckout(String checkoutId) async {
    Map<dynamic, dynamic> args = new Map();
    args[kArgCheckoutId] = checkoutId;

    final String responseJson =
    await _channel.invokeMethod(kMethodGetCheckout, args);
    final responseMap = json.decode(responseJson);
    final Checkout response = Checkout.fromJson(responseMap);

    return response;
  }

  static Future<Checkout> setShippingAddress(String checkoutId,
      Address address) async {

    Map<dynamic, dynamic> args = new Map();
    args[kArgCheckoutId] = checkoutId;
    args[kArgAddressId] = address.id;
    args[kArgPrimaryAddress] = address.address;
    args[kArgSecondAddress] = address.secondAddress;
    args[kArgCity] = address.city;
    args[kArgState] = address.state;
    args[kArgCountry] = address.country;
    args[kArgFirstName] = address.firstName;
    args[kArgLastName] = address.lastName;
    args[kArgZip] = address.zip;
    args[kArgPhone] = address.phone;

    final String responseJson = await _channel.invokeMethod(
      kMethodSetShippingAddress, args,);
    final responseMap = json.decode(responseJson);
    final Checkout response = Checkout.fromJson(responseMap);

    return response;
  }

  static Future<List<ShippingRate>> getShippingRates(String checkoutId) async {
    Map<dynamic, dynamic> args = new Map();
    args[kArgCheckoutId] = checkoutId;

    final String responseJson = await _channel.invokeMethod(
      kMethodGetShippingRates, args,);
    final responseMap = json.decode(responseJson).cast<Map<String, dynamic>>();
    final List<ShippingRate> response = responseMap
        .map<ShippingRate>((json) => ShippingRate.fromJson(json))
        .toList();

    return response;
  }

  static Future<Checkout> selectShippingRate(String checkoutId,
      ShippingRate shippingRate) async {

    Map<dynamic, dynamic> args = new Map();
    args[kArgCheckoutId] = checkoutId;
    args[kArgTitle] = shippingRate.title;
    args[kArgPrice] = shippingRate.price;
    args[kArgHandle] = shippingRate.handle;
//    args[kArgShippingRate] = shippingRate;

    final String responseJson = await _channel.invokeMethod(
      kMethodSelectShippingRate, args,);
    final responseMap = json.decode(responseJson);
    final Checkout response = Checkout.fromJson(responseMap);

    return response;
  }

  static Future<List<CardType>> getAcceptedCardTypes() async {
    //TODO test and check
    final List<CardType> response = await _channel.invokeMethod(
      kMethodGetAcceptedCardTypes,);

    return response;
  }

  static Future<String> getCardToken(CardDetails card) async {
    Map<dynamic, dynamic> args = new Map();
    args[kArgCardFirstName] = card.firstName;
    args[kArgCardLastName] = card.lastName;
    args[kArgCardNumber] = card.cardNumber;
    args[kArgCardExpireMonth] = card.expireMonth;
    args[kArgCardExpireYear] = card.expireYear;
    args[kArgCardVerificationCode] = card.verificationCode;

    final String response = await _channel.invokeMethod(
      kMethodGetCardToken, args,);

    return response;
  }

  static Future<Order> completeCheckoutByCard(Checkout checkout, String email,
      Address address, String creditCardValueToken) async {

    Map<dynamic, dynamic> args = new Map();

    String addressJson = json.encode(address);
    args[kArgAddressJson] = addressJson;

    String checkoutJson = json.encode(checkout);
    args[kArgCheckoutJson] = checkoutJson;

    args[kArgEmail] = email;

    args[kArgCreditCardValueToken] = creditCardValueToken;

    final String responseJson = await _channel.invokeMethod(
      kMethodCompleteCheckoutByCard, args,);
    final responseMap = json.decode(responseJson);
    final Order response = Order.fromJson(responseMap);

    return response;
  }


  //////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////  ORDERS  /////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  static Future<List<Order>> getOrders(int perPage, dynamic paginationValue)
  async {

    Map<dynamic, dynamic> args = new Map();
    args[kArgPerPage] = perPage;
    args[kArgPaginationValue] = paginationValue;

    List<Order> response;

    await _channel.invokeMethod(
      kMethodGetOrders, args,).then((value) {

      if (value.contains("No Orders")) {
        response = new List();
      }
      else if (value.contains("onFailure")) {
        response = null;
      }
      else {
        final responseMap = json.decode(value).cast<Map<String, dynamic>>();
        response = responseMap.map<Order>((json) =>
            getOrder1(json),).toList();
      }
    }).catchError((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    });

    return response;
  }

  static Order getOrder1(dynamic item) {

    if (item['totalShippingPrice'] == null) {
      item['totalShippingPrice'] = 0.0;
    }

    if (item['subtotalPrice'] == null) {
      item['subtotalPrice'] = 0.0;
    }

    if (item['totalPrice'] == null) {
      item['totalPrice'] = 0.0;
    }

    if (item['address'] == null) {
      item['address'] = new Map<String, dynamic>();
    }

    if (item['orderProducts'] != null) {
      List<dynamic> list = item['orderProducts'];
      list.forEach((item) {
        if (item['productVariant'] == null) {
          Map<String, dynamic> variantMap = new Map<String, dynamic>();
          variantMap['price'] = 0;
          variantMap['selectedOptions'] = new List();
          variantMap['image'] = new Map<String, dynamic>();
          variantMap['productImage'] = new Map<String, dynamic>();

          item['productVariant'] = variantMap;
        }
      });
    }

    return Order.fromJson(item);
  }

  static Future<Order> getOrder(String orderId) async {
    Map<dynamic, dynamic> args = new Map();
    args[kArgOrderId] = orderId;

    Order response;
    await _channel.invokeMethod(
      kMethodGetOrder, args,).then((value) {
      final responseMap = json.decode(value);
      response = Order.fromJson(responseMap);
    }).catchError(((e) {
      throw PlatformException(code: e.code, message: e.message, details: e.details);
    }));

    return response;
  }
}

