import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopify/domain/initialize_params.dart';
import 'package:shopify/shopify.dart';
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
import 'package:shopify/model/sort_type.dart' as sort;

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    initShopify();
  }

  Future<void>  initShopify() async {

    await Shopify.platformVersion.then((val) {
      print(val);
    });

    ShopifyInitializeParams params = new ShopifyInitializeParams();
    params.domainName = "porganicworld.myshopify.com";
    params.accessToken = "62761bc137e3dac4c66d1d1a93d8dab3";
    params.apiKey = "1e5f1c6facb67ef0bf9e0c4af642d192";
    params.apiPassword = "5c3061bb2e053642fc1422409ccbb89e";
    await Shopify.initialize(params);

    signIn();
//    getProductsList(); //variantList is coming  null in this call
//    getProduct(); //variantList is present in individual product call
//    getProductVariants();
//    searchProductList();

    getCategories();
    getCategoryDetails();

//    getArticleList(); //ArticleList is itself empty
//    getArticle();

//    getShopInfo();

//    signUp(); // phone no with country code is mandatory

   // getAccessToken();
//    signOut();
//    isLoggedIn(); // is always false
//    forgotPassword();
//    changePassword();

//    getCountries();
//    getCustomer();

//    createCustomerAddress();
//    setDefaultShippingAddress();
//    editCustomerAddress();
//    deleteCustomerAddress();

    editCustomerInfo();

//    updateCustomerSettings();

//    getOrder(); //PlatformException and null pointer exception
//    getOrders(); //onFailure -- com.shopapp.gateway.entity.Error$NonCritical: Unauthorized

//    createCheckout();
//    getCheckout();

//    setShippingAddress(); //What checkOutId we should supply? - class cast exception
//    getShippingRates();

//    selectShippingRate(); // What checkOutId we should supply? - Unhandled exception

//    getAcceptedCardTypes();
//    getCardToken(); //exception
//    completeCheckoutByCard(); //exception

//  startShopping();
  }

  Future<void> startShopping() async {
    List<Category> categories = await Shopify.getCategoryList(5, null);
    List<Product> selectedProducts = await getSelectedProducts(categories);
    List<CartProduct> cartItems = await prepareCartItems(selectedProducts);
    Checkout checkout = await Shopify.createCheckout(cartItems);
//    checkout = await Shopify.getCheckout(checkout.checkoutId);
    print('Checkout - $checkout');
  }

  Future<List<Product>> getSelectedProducts(List<Category> categories) async {
    List<Product> selectedProducts = new List();

    for (Category category in categories) {
      await prepareProducts(category, selectedProducts);
    }
    return selectedProducts;
  }

  Future<void> prepareProducts(Category category, List<Product> selectedProducts) async {
    category = await Shopify.getCategoryDetails(category.id, 10, null, null);

    await prepare(category.productList, selectedProducts);
  }

  Future<void> prepare(List<Product> products, List<Product> selectedProducts) async {
    if (products != null && products.length > 0) {
      Product product1 = await Shopify.getProduct(products[0].id);
      bool isProduct1Available = true;
      if (product1.variants != null && product1.variants.length > 0) {
        for (ProductVariant variant in product1.variants) {
          if (!variant.isAvailable) {
            isProduct1Available = false;
            break;
          }
        }
      }
      if (isProduct1Available) {
        selectedProducts.add(product1);
      }
      if (products.length > 1) {
        Product product2 = await Shopify.getProduct(products[1].id);
        bool isProduct2Available = true;
        if (product2.variants != null && product2.variants.length > 0) {
          for (ProductVariant variant in product2.variants) {
            if (!variant.isAvailable) {
              isProduct2Available = false;
              break;
            }
          }
        }
        if (isProduct2Available) {
          selectedProducts.add(product2);
        }
      }
    }
  }

  Future<List<CartProduct>> prepareCartItems(List<Product> selectedProducts) async {
    List<CartProduct> cartItems = new List();
    selectedProducts.forEach((product) {
      CartProduct cartProduct = new CartProduct();
      cartProduct.title = product.title;
      cartProduct.currency = product.currency;
      cartProduct.quantity = 1;
      if (product.variants != null && product.variants.length > 0) {
        cartProduct.productVariant = product.variants[0];
      }
      cartItems.add(cartProduct);
    });
    return cartItems;
  }

  Future<void> getProductsList() async {
    List<Product> products =  await Shopify.getProductList(150, null, null, null, null);
    print('Products - $products');
  }

  Future<void> getProduct() async {
    Product product = await Shopify.getProduct("Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0LzE0NzgxNjU3NTgwMTE=");
    print('Product - $product');
  }

  Future<void> getCategories() async {
    List<Category> categories = await Shopify.getCategoryList(15, null);
    print('Categories - $categories');
  }

  Future<void> getCategoryDetails() async {
    Category category = await Shopify.getCategoryDetails(
        "Z2lkOi8vc2hvcGlmeS9Db2xsZWN0aW9uLzY1MTk3ODY3MDY3", 15, null, sort.SortType.NAME);
    //Jewellery
    print('Category - $category');
  }

  Future<void> getProductVariants() async {
    List<Product> products =  await Shopify.getProductList(5, null, null, null, null);
    List<String> productVariantIds = new List();
    products.forEach((product) {
      for (int i = 0 ; i < product.variants.length; i++) {
        productVariantIds.add(product.variants[i].id);
      }
    });

    Product product = await Shopify.getProduct("Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0LzE0NzgxNjU3NTgwMTE=");
    for (int i = 0 ; i < product.variants.length; i++) {
      productVariantIds.add(product.variants[i].id);
    }
    print('main : ProductVariantListManual - $productVariantIds');

    List<ProductVariant> productVariants =  await Shopify.getProductVariantList(productVariantIds);
    print('main : ProductVariantList - $productVariants');
  }

  Future<void> searchProductList() async {
    List<Product> searchProducts =  await Shopify.searchProductList("Ursa", 3,
        null);
    print('main : searchProducts - $searchProducts');
  }

  Future<void> getArticleList() async {
    List<Article> articlesList =  await Shopify.getArticleList(3, null, null, true);
    print('main : ArticlesList - $articlesList');
  }

  Future<void> getArticle() async {
    Article article =  await Shopify.getArticle(""); //TODO pass article id
    print('main : article - $article');
  }

  Future<void> getShopInfo() async {
    Shop shop = await Shopify.getShopInfo();
    print('Shop - $shop');
  }

  Future<void> signIn() async {
    //bool val = await Shopify.signIn("imei355923070770619@gmail.com", "bFppaybqvWaD6CZdAtL5T7FN1XF2");
    bool val = await Shopify.signIn("test@gmail.com", "test123456");

    print('Result - $val');
    getCustomer();
  }

  Future<void> getAccessToken() async {
    String val = await Shopify.getAccessToken();
    print('Result - $val');
  }

  Future<void> signOut() async {
    bool val = await Shopify.signOut();
    print('Result - $val');
  }

  Future<void> signUp() async {
    String val = await Shopify.signUp("pragna", "katreddy", "pragna.0303@gmail.com", "12345", "+918985940000");
    print('Result - $val');
  }

  Future<void> isLoggedIn() async {
    bool val = await Shopify.isLoggedIn();
    print('Result - $val');
  }

  Future<void> forgotPassword() async {
    bool val = await Shopify.forgotPassword("pallavis@purnatva.com");
    print('Result - $val');
  }

  Future<void> changePassword() async {
    bool val = await Shopify.changePassword("abc123-");
    print('Result - $val');
  }

  Future<void> getCountries() async {
    List<Country> countries = await Shopify.getCountries();
    int number = countries.length;
    print('Result - $number');
  }

  Future<void> getCustomer() async {
    Customer customer = await Shopify.getCustomer();
    print('Result - $customer');
  }

  Future<void> setDefaultShippingAddress() async {
    bool val = await Shopify.setDefaultShippingAddress("Z2lkOi8vc2hvcGlmeS9NYWlsaW5nQWRkcmVzcy83OTcwMTE2MDc2MTE/bW9kZWxfbmFtZT1DdXN0b21lckFkZHJlc3MmY3VzdG9tZXJfYWNjZXNzX3Rva2VuPTZDUEtFaUJxRk9LdEVpQTRIYks1MHdCVTJubkI3Yzc3NW84ZXNnZUxfMUVFbEFtOWhRcExzRFgyOEozejhkTnE2SFRwX2J4SThqc0NlcTlIUE9mWW9vM3F4bXdraUs3aktJQ1E0SVVzMktqS19RLVFCeDhWdW9sWjRDNjdkbjVRWTJROUJkSHYxaGpSQUlELXlsb19YaDBiZGRZWjB2alltdE5Ueklsbm5ZZnlwSzlaM09adVdmUXVFRVlLeE9NYkFTbG5lTGhDNDgyQ1J0QUhTYS1ZTl9yS3dQNW9RbVVmb0QxRDRlaHZlbGdNS0hVY0xtcEgzOHJMWUJKbDJBazI=");
    print('Result - $val');
  }

  Future<void> createCustomerAddress() async {
    Address address = new Address();
    address.address = "primary address";
    address.secondAddress = "second Address";
    address.city = "blr city";
    address.state = "Karnataka";
    address.country = "INDIA";
    address.firstName = "pragna";
    address.lastName = "k";
    address.zip = "560078";
    address.phone = "+918985940000";
    String addressId = await Shopify.createCustomerAddress(address);
    print('Result - $addressId');
  }

  Future<void> editCustomerAddress() async {
    Address address = new Address();
    address.id = "Z2lkOi8vc2hvcGlmeS9NYWlsaW5nQWRkcmVzcy83OTcwMTE2MDc2MTE/bW9kZWxfbmFtZT1DdXN0b21lckFkZHJlc3MmY3VzdG9tZXJfYWNjZXNzX3Rva2VuPTZDUEtFaUJxRk9LdEVpQTRIYks1MHdCVTJubkI3Yzc3NW84ZXNnZUxfMUVFbEFtOWhRcExzRFgyOEozejhkTnE2SFRwX2J4SThqc0NlcTlIUE9mWW9vM3F4bXdraUs3aktJQ1E0SVVzMktqS19RLVFCeDhWdW9sWjRDNjdkbjVRWTJROUJkSHYxaGpSQUlELXlsb19YaDBiZGRZWjB2alltdE5Ueklsbm5ZZnlwSzlaM09adVdmUXVFRVlLeE9NYkFTbG5lTGhDNDgyQ1J0QUhTYS1ZTl9yS3dQNW9RbVVmb0QxRDRlaHZlbGdNS0hVY0xtcEgzOHJMWUJKbDJBazI=";
    address.address = "primary address changed";
    address.secondAddress = "second Address changed";
    address.city = "blr city";
    address.state = "Karnataka";
    address.country = "INDIA";
    address.firstName = "pallavi";
    address.lastName = "s";
    address.zip = "560078";
    address.company = "Office";
    address.phone = "+918985940000";
    bool val = await Shopify.editCustomerAddress(address.id, address);
    print('Result - $val');
  }

  Future<void> deleteCustomerAddress() async {
    Address address = new Address();
    bool val = await Shopify.deleteCustomerAddress("Z2lkOi8vc2hvcGlmeS9NYWlsaW5nQWRkcmVzcy83OTcwMTE2MDc2MTE/bW9kZWxfbmFtZT1DdXN0b21lckFkZHJlc3MmY3VzdG9tZXJfYWNjZXNzX3Rva2VuPTZDUEtFaUJxRk9LdEVpQTRIYks1MHdCVTJubkI3Yzc3NW84ZXNnZUxfMUVFbEFtOWhRcExzRFgyOEozejhkTnE2SFRwX2J4SThqc0NlcTlIUE9mWW9vM3F4bXdraUs3aktJQ1E0SVVzMktqS19RLVFCeDhWdW9sWjRDNjdkbjVRWTJROUJkSHYxaGpSQUlELXlsb19YaDBiZGRZWjB2alltdE5Ueklsbm5ZZnlwSzlaM09adVdmUXVFRVlLeE9NYkFTbG5lTGhDNDgyQ1J0QUhTYS1ZTl9yS3dQNW9RbVVmb0QxRDRlaHZlbGdNS0hVY0xtcEgzOHJMWUJKbDJBazI=");
    print('Result - $val');
  }

  Future<void> editCustomerInfo() async {
    Customer customer = await Shopify.editCustomerInfo("pallavi", "s", "+918985941111","seshu.mca@test")
    .then((value){
      print("Got error: ${value}");
    }) // Future completes with two()'s error.
    .catchError((e) {
      print("Got error: ${e}");     // Finally, callback fires.
    });
    print('Result - $customer');
  }

  Future<void> updateCustomerSettings() async {
    bool val = await Shopify.updateCustomerSettings(false);
    print('Result - $val');
  }

  Future<void> getOrders() async {
    List<Order> orders = await Shopify.getOrders(5, null);
    print('Result - $orders');
  }

  Future<void> getOrder() async {
    Order order = await Shopify.getOrder("orderId");
    print('Result - $order');
  }

  Future<void> createCheckout() async {
    List<CartProduct> cartProducts = prepareCartProducts();
    Checkout checkout = await Shopify.createCheckout(cartProducts);
    print('Result - $checkout');
  }

  List<CartProduct> prepareCartProducts() {
    List<CartProduct> products = new List();
    products.add(new CartProduct(/*productVariant: new ProductVariant(id: "1",
        title: "dummy variant 1", price: 99.0, productId: "11"),*/
        title: "Cart Product 1", currency: "Indian Rupee", quantity: 3));

    products.add(new CartProduct(/*productVariant: new ProductVariant(id: "2",
        title: "dummy variant 2", price: 9.0, productId: "22"),*/
        title: "Cart Product 2", currency: "US dollar", quantity: 1));

    products.add(new CartProduct(/*productVariant: new ProductVariant(id: "3",
        title: "dummy variant 3", price: 999.0, productId: "33"),*/
        title: "Cart Product 3", currency: "Indian Rupee", quantity: 5));

    return products;
  }

  Future<void> getCheckout() async {
    Checkout checkout = await Shopify.getCheckout("Z2lkOi8vc2hvcGlmeS9DaGVja291dC9hNjc0NjY4MDcwZThhMjcyNzAyZmM0ZWMwYTAwOTNhMj9rZXk9Nzc2YzJkNWJmZWY2OTNlZjMxY2U0NmViMDBjMjMyMGY=");
    print('Result - $checkout');
  }

  Future<void> setShippingAddress() async {
    Address address = new Address();
    address.id = "Z2lkOi8vc2hvcGlmeS9NYWlsaW5nQWRkcmVzcy83OTcwMTE2MDc2MTE/bW9kZWxfbmFtZT1DdXN0b21lckFkZHJlc3MmY3VzdG9tZXJfYWNjZXNzX3Rva2VuPTZDUEtFaUJxRk9LdEVpQTRIYks1MHdCVTJubkI3Yzc3NW84ZXNnZUxfMUVFbEFtOWhRcExzRFgyOEozejhkTnE2SFRwX2J4SThqc0NlcTlIUE9mWW9vM3F4bXdraUs3aktJQ1E0SVVzMktqS19RLVFCeDhWdW9sWjRDNjdkbjVRWTJROUJkSHYxaGpSQUlELXlsb19YaDBiZGRZWjB2alltdE5Ueklsbm5ZZnlwSzlaM09adVdmUXVFRVlLeE9NYkFTbG5lTGhDNDgyQ1J0QUhTYS1ZTl9yS3dQNW9RbVVmb0QxRDRlaHZlbGdNS0hVY0xtcEgzOHJMWUJKbDJBazI=";
    address.address = "primary address changed";
    address.secondAddress = "second Address changed";
    address.city = "blr city";
    address.state = "Karnataka";
    address.country = "INDIA";
    address.firstName = "pallavi";
    address.lastName = "s";
    address.zip = "560078";
    address.phone = "+918985940000";
    Checkout checkout = await Shopify.setShippingAddress("Z2lkOi8vc2hvcGlmeS9DaGVja291dC9hNjc0NjY4MDcwZThhMjcyNzAyZmM0ZWMwYTAwOTNhMj9rZXk9Nzc2YzJkNWJmZWY2OTNlZjMxY2U0NmViMDBjMjMyMGY=", address);
    print('Result - $checkout');
  }

  Future<void> getShippingRates() async {
    List<ShippingRate> rates = await Shopify.getShippingRates("Z2lkOi8vc2hvcGlmeS9DaGVja291dC9hNjc0NjY4MDcwZThhMjcyNzAyZmM0ZWMwYTAwOTNhMj9rZXk9Nzc2YzJkNWJmZWY2OTNlZjMxY2U0NmViMDBjMjMyMGY=");
    print('Result - $rates');
  }

  Future<void> selectShippingRate() async {
    ShippingRate rate = new ShippingRate(title: "1", price: 0.0, handle: "2");
    Checkout checkout = await Shopify.selectShippingRate("Z2lkOi8vc2hvcGlmeS9DaGVja291dC9hNjc0NjY4MDcwZThhMjcyNzAyZmM0ZWMwYTAwOTNhMj9rZXk9Nzc2YzJkNWJmZWY2OTNlZjMxY2U0NmViMDBjMjMyMGY=", rate);
    print('Result - $checkout');
  }

  Future<void> getAcceptedCardTypes() async {
    List<CardType> cardTypes = await Shopify.getAcceptedCardTypes();
    print('Result - $cardTypes');
  }

  Future<void> getCardToken() async {
    CardDetails card = new CardDetails(firstName: "Ted", lastName: "X",
        cardNumber: "1234-5678-9101-1121", expireMonth: "June",
        expireYear: "2019", verificationCode: "111");
    String val = await Shopify.getCardToken(card);
    print('Result - $val');
  }

  Future<void> completeCheckoutByCard() async {
    Checkout checkout = await Shopify.getCheckout("Z2lkOi8vc2hvcGlmeS9DaGVja291dC8zYzA3NGI5ZjYyNDA5MmVhYWFkMzM4MTkxNDVlMDBhZT9rZXk9N2I3MDkwNGEyMDQ1NzkzYmZmMzFiOGI1NmQ1ZTgzMTE=");

    Address address = new Address();
    address.id = "Z2lkOi8vc2hvcGlmeS9NYWlsaW5nQWRkcmVzcy83OTcwMTE2MDc2MTE/bW9kZWxfbmFtZT1DdXN0b21lckFkZHJlc3MmY3VzdG9tZXJfYWNjZXNzX3Rva2VuPTZDUEtFaUJxRk9LdEVpQTRIYks1MHdCVTJubkI3Yzc3NW84ZXNnZUxfMUVFbEFtOWhRcExzRFgyOEozejhkTnE2SFRwX2J4SThqc0NlcTlIUE9mWW9vM3F4bXdraUs3aktJQ1E0SVVzMktqS19RLVFCeDhWdW9sWjRDNjdkbjVRWTJROUJkSHYxaGpSQUlELXlsb19YaDBiZGRZWjB2alltdE5Ueklsbm5ZZnlwSzlaM09adVdmUXVFRVlLeE9NYkFTbG5lTGhDNDgyQ1J0QUhTYS1ZTl9yS3dQNW9RbVVmb0QxRDRlaHZlbGdNS0hVY0xtcEgzOHJMWUJKbDJBazI=";
    address.address = "primary address changed";
    address.secondAddress = "second Address changed";
    address.city = "blr city";
    address.state = "Karnataka";
    address.country = "INDIA";
    address.firstName = "pallavi";
    address.lastName = "s";
    address.zip = "560078";
    address.phone = "+918985940000";

    Order order = await Shopify.completeCheckoutByCard(checkout, "hello@hi.com", address, "ccValueToken");
    print('Result - $order');
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text("TODO : UI : Pending"),
        ),
      ),
    );
  }

}
