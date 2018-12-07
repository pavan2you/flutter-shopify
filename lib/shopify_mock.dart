import 'dart:async';

import 'package:shopify/model/address.dart';
import 'package:shopify/model/category.dart';
import 'package:shopify/model/delivery_info.dart';
import 'package:shopify/model/image.dart';
import 'package:shopify/model/offer_product.dart';
import 'package:shopify/model/order.dart';
import 'package:shopify/model/order_product.dart';
import 'package:shopify/model/product.dart';
import 'package:shopify/model/product_variant.dart';
import 'package:shopify/model/store.dart';
import 'package:shopify/shopify_constants.dart';

class MockShopify {

  static Future<List<Order>> getMockOrders(int perPage, dynamic paginationValue) async {

    Map<dynamic, dynamic> args = new Map();
    args[kArgPerPage] = perPage;
    args[kArgPaginationValue] = paginationValue;

    List<Order> orders = new List();
    Order order1 = new Order();
    order1.id = "1";
    order1.processedAt = "Dec 01, 2018";
    order1.orderNumber = 2; // need to change wrt status
    orders.add(order1);

    Order order2 = new Order();
    order2.id = "2";
    order2.processedAt = "Dec 02, 2018";
    order2.orderNumber = 1; // need to change wrt status
    orders.add(order2);

    return orders;
  }


  static Future<List<OfferProduct>> getMockOfferProducts(int perPage,
      dynamic paginationValue) async {
    Map<dynamic, dynamic> args = new Map();
    args[kArgPerPage] = perPage;
    args[kArgPaginationValue] = paginationValue;

    List<OfferProduct> offerProducts = new List();

    OfferProduct op1 = new OfferProduct();
    Product product = new Product();
    product.id = "Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0LzE0NzgxNjU3NTgwMTE=";
    product.title = "The Scout Skincare Kit";
    product.productDescription= "This is a demonstration store. You can purchase products like this from United By Blue. A collection of the best Ursa Major has to offer! The Scout kit contains travel sizes of their best selling skin care items including: Face Wash (2 fl oz) Shave Cream (2 fl oz) Face Balm (0.5 fl oz) 5 tonic-infused bamboo Face Wipes All wrapped together in a great, reusable tin.";
    product.additionalDescription = "This is a demonstration store. You can purchase products like this from United By Blue. A collection of the best Ursa Major has to offer! The Scout kit contains travel sizes of their best selling skin care items including: Face Wash (2 fl oz) Shave Cream (2 fl oz) Face Balm (0.5 fl oz) 5 tonic-infused bamboo Face Wipes All wrapped together in a great, reusable tin.";
    product.currency = "INR";
    product.price = 136.0;
    product.hasAlternativePrice = false;
    product.discount = "40";
    product.vendor = "Ursa Major";
    product.type = "Accessories";
    product.createdAt = "Aug 20, 2018 6:18:45 PM";
    product.updatedAt = "Aug 20, 2018 6:20:24 PM";
    product.paginationValue = "eyJsYXN0X2lkIjoxNDc4MTY1NzU4MDExLCJsYXN0X3ZhbHVlIjoiMCJ9";

    product.images = [];
    ImageDTO image1 = new ImageDTO();
    image1.id = "Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0SW1hZ2UvNDQ5MTQ3MTc4MTk0Nw==";
    image1.src = "https://cdn.shopify.com/s/files/1/0083/1664/9531/products/hudderton-backpack_dc8afb13-448b-49d9-a042-5a163a97de8f.jpg?v=1534769369";
    product.images.add(image1);

    op1.product = product;
    op1.offerPrice = 80.0;
    offerProducts.add(op1);

    OfferProduct op2 = new OfferProduct();
    Product product2 = new Product();
    product2.id = "Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0LzE0NzgxNjkzNjI0OTE=";
    product2.title = "Camp Stool";
    product2.productDescription= "This is a demonstration store. You can purchase products like this from United By Blue. A collection of the best Ursa Major has to offer! The Scout kit contains travel sizes of their best selling skin care items including: Face Wash (2 fl oz) Shave Cream (2 fl oz) Face Balm (0.5 fl oz) 5 tonic-infused bamboo Face Wipes All wrapped together in a great, reusable tin.";
    product2.additionalDescription = "This is a demonstration store. You can purchase products like this from United By Blue. A collection of the best Ursa Major has to offer! The Scout kit contains travel sizes of their best selling skin care items including: Face Wash (2 fl oz) Shave Cream (2 fl oz) Face Balm (0.5 fl oz) 5 tonic-infused bamboo Face Wipes All wrapped together in a great, reusable tin.";
    product2.currency = "INR";
    product2.price = 100.0;
    product2.hasAlternativePrice = false;
    product2.discount = "50";
    product2.vendor = "United By Blue";
    product2.type = "Outdoor";
    product2.createdAt = "Aug 20, 2018 6:18:45 PM";
    product2.updatedAt = "Aug 20, 2018 6:20:24 PM";
    product2.paginationValue = "eyJsYXN0X2lkIjoxNDc4MTY1NzU4MDExLCJsYXN0X3ZhbHVlIjoiMCJ9";

    product2.images = [];
    ImageDTO image2 = new ImageDTO();
    image2.id = "Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0SW1hZ2UvNDQ5MTQ3MTM4ODczMQ==";
    image2.src = "https://cdn.shopify.com/s/files/1/0083/1664/9531/products/campstool-1.jpg?v=1534769368";
    product2.images.add(image2);

    op2.product = product2;
    op2.offerPrice = 50.0;
    offerProducts.add(op2);

    OfferProduct op3 = new OfferProduct();
    Product product3 = new Product();
    product3.id = "Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0LzE0NzgxNjkxOTg2NTE=";
    product3.title = "The Field Report Vol. 2";
    product3.productDescription= "This is a demonstration store. You can purchase products like this from United By Blue. A collection of the best Ursa Major has to offer! The Scout kit contains travel sizes of their best selling skin care items including: Face Wash (2 fl oz) Shave Cream (2 fl oz) Face Balm (0.5 fl oz) 5 tonic-infused bamboo Face Wipes All wrapped together in a great, reusable tin.";
    product3.additionalDescription = "This is a demonstration store. You can purchase products like this from United By Blue. A collection of the best Ursa Major has to offer! The Scout kit contains travel sizes of their best selling skin care items including: Face Wash (2 fl oz) Shave Cream (2 fl oz) Face Balm (0.5 fl oz) 5 tonic-infused bamboo Face Wipes All wrapped together in a great, reusable tin.";
    product3.currency = "INR";
    product3.price = 200.0;
    product3.hasAlternativePrice = false;
    product3.discount = "25";
    product3.vendor = "United By Blue";
    product3.type = "Home";
    product3.createdAt = "Aug 20, 2018 6:18:45 PM";
    product3.updatedAt = "Aug 20, 2018 6:20:24 PM";
    product3.paginationValue = "eyJsYXN0X2lkIjoxNDc4MTY1NzU4MDExLCJsYXN0X3ZhbHVlIjoiMCJ9";

    product3.images = [];
    ImageDTO image3 = new ImageDTO();
    image3.id = "Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0SW1hZ2UvNDQ5MTQ3MTE1OTM1NQ==";
    image3.src = "https://cdn.shopify.com/s/files/1/0083/1664/9531/products/fieldreport_vol2_front_437c4459-042c-4b07-8018-f092a5eb83ac.jpg?v=1534769366";
    product3.images.add(image3);

    op3.product = product3;
    op3.offerPrice = 150.0;
    offerProducts.add(op3);

    OfferProduct op4 = new OfferProduct();
    Product product4 = new Product();
    product4.id = "Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0LzE0NzgxNjkwNjc1Nzk=";
    product4.title = "Double Wall Mug";
    product4.productDescription= "This is a demonstration store. You can purchase products like this from United By Blue. A collection of the best Ursa Major has to offer! The Scout kit contains travel sizes of their best selling skin care items including: Face Wash (2 fl oz) Shave Cream (2 fl oz) Face Balm (0.5 fl oz) 5 tonic-infused bamboo Face Wipes All wrapped together in a great, reusable tin.";
    product4.additionalDescription = "This is a demonstration store. You can purchase products like this from United By Blue. A collection of the best Ursa Major has to offer! The Scout kit contains travel sizes of their best selling skin care items including: Face Wash (2 fl oz) Shave Cream (2 fl oz) Face Balm (0.5 fl oz) 5 tonic-infused bamboo Face Wipes All wrapped together in a great, reusable tin.";
    product4.currency = "INR";
    product4.price = 1000.0;
    product4.hasAlternativePrice = false;
    product4.discount = "10";
    product4.vendor = "Snow Peak";
    product4.type = "Outdoor";
    product4.createdAt = "Aug 20, 2018 6:18:45 PM";
    product4.updatedAt = "Aug 20, 2018 6:20:24 PM";
    product4.paginationValue = "eyJsYXN0X2lkIjoxNDc4MTY1NzU4MDExLCJsYXN0X3ZhbHVlIjoiMCJ9";

    product4.images = [];
    ImageDTO image4 = new ImageDTO();
    image4.id = "Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0SW1hZ2UvNDQ5MTQ3MDg5NzIxMQ==";
    image4.src = "https://cdn.shopify.com/s/files/1/0083/1664/9531/products/mug.jpg?v=1534769365";
    product4.images.add(image4);

    op4.product = product4;
    op4.offerPrice = 900.0;
    offerProducts.add(op4);

    return offerProducts;
  }

  static Future<List<Category>> prepareMockGridCategories() async {
    List<Category> categories = [];

    Category fruits = new Category();
    fruits.id = "0";
    fruits.title = "Vegetables";
    fruits.image = new ImageDTO();
    fruits.image.id = "assets/images/c_vegitables.jpg";
    categories.add(fruits);

    Category foodGrains = new Category();
    foodGrains.id = "1";
    foodGrains.title = "Fruits";
    foodGrains.image = new ImageDTO();
    foodGrains.image.id = "assets/images/c_fruits.jpg";
    categories.add(foodGrains);

    Category bakery = new Category();
    bakery.id = "2";
    bakery.title = "Staples";
    bakery.image = new ImageDTO();
    bakery.image.id = "assets/images/c_staples.jpg";
    categories.add(bakery);

    Category beverages = new Category();
    beverages.id = "3";
    beverages.title = "Beverages";
    beverages.image = new ImageDTO();
    beverages.image.id = "assets/images/c_beverages.jpg";
    categories.add(beverages);

    Category snacks = new Category();
    snacks.id = "4";
    snacks.title = "Snacks";
    snacks.image = new ImageDTO();
    snacks.image.id = "assets/images/c_packaged_food.jpg";
    categories.add(snacks);

    Category beauty = new Category();
    beauty.id = "5";
    beauty.title = "Diary";
    beauty.image = new ImageDTO();
    beauty.image.id = "assets/images/c_dairy.jpg";
    categories.add(beauty);

    Category cleaning = new Category();
    cleaning.id = "6";
    cleaning.title = "Cleaning";
    cleaning.image = new ImageDTO();
    cleaning.image.id = "assets/images/c_fruits.jpg";
    categories.add(cleaning);

    Category kitchen = new Category();
    kitchen.id = "7";
    kitchen.title = "Kitchen";
    kitchen.image = new ImageDTO();
    kitchen.image.id = "assets/images/c_beverages.jpg";
    categories.add(kitchen);

    Category eggs = new Category();
    eggs.id = "8";
    eggs.title = "Poultry";
    eggs.image = new ImageDTO();
    eggs.image.id = "assets/images/c_staples.jpg";
    categories.add(eggs);
    return categories;
  }

  static Future<DeliveryInfo> fetchDeliveryInfo() async {
    DeliveryInfo deliveryInfo = new DeliveryInfo();
    deliveryInfo.minDeliveryCharges = 20.0;
    deliveryInfo.minPriceForFreeDelivery = 1500.0;
    deliveryInfo.numberOfShipments = 1;
    deliveryInfo.availableDeliverySlots = [];

    deliveryInfo.availableDeliverySlots.add("Tomorrow");
    deliveryInfo.availableDeliverySlots.add("9.00 AM-11.30 AM");
    deliveryInfo.availableDeliverySlots.add("11.30 AM-1.00 PM");
    deliveryInfo.availableDeliverySlots.add("1.00 PM-3.30 PM");
    deliveryInfo.availableDeliverySlots.add("3.30 PM-5.00 PM");
    deliveryInfo.availableDeliverySlots.add("5.00 PM-7.30 PM");
    deliveryInfo.availableDeliverySlots.add("7.30 PM-10.00 PM");

    deliveryInfo.defaultSelectedDeliverySlot = "Tomorrow 11.30 AM-1.00 PM";
    return deliveryInfo;
  }

  static List<Store> getMockStores() {
    List<Store> stores = new List();

    stores.add(new Store(
        storeId: "560011",
        storeName: "TOW - Jaya Nagar III block",
        storeAddress: "Store is not avaliable but delivery is avaliable"));

    stores.add(new Store(
        storeId: "560034",
        storeName: "TOW - Jakkasandra - Koramangala",
        storeAddress: "#44, 100 Feet Rd, 4th Block, Koramangala 4th Block,"
            " Koramangala, Bengaluru, Karnataka"));

    stores.add(new Store(
        storeId: "560041",
        storeName: "TOW - Jaya Nagar T block",
        storeAddress: "Store is not avaliable but delivery is avaliable"));

    stores.add(new Store(
        storeId: "560070",
        storeName: "TOW - Jaya Nagar",
        storeAddress: "Store is not avaliable but delivery is avaliable"));

    stores.add(new Store(
        storeId: "560076",
        storeName: "TOW - Doddakammanahalli",
        storeAddress: "Store is not avaliable but delivery is avaliable"));

    stores.add(new Store(
        storeId: "560078",
        storeName: "TOW - JP Nagar",
        storeAddress: "58, 15th Cross Rd, Jeewan Griha Colony, 2nd Phase,"
            " JP Nagar, Bengaluru, Karnataka"));

    stores.add(new Store(
        storeId: "560095",
        storeName: "TOW - HSR",
        storeAddress: "No. 483, 17th Cross, 27th Main Rd, Opposite Nift,"
            "Sector 2, HSR Layout, Bengaluru, Karnataka"));

    return stores;
  }

  static Future<List<Order>> getMockOrderList() async {
    List<Order> orders = new List();

    orders.add(new Order(
        id: "1",
        processedAt : "Dec 01, 2018",
        orderNumber: 1,
        orderProducts: await getMockOrderProducts(),
        address: getMockAddress(0)));

    orders.add(new Order(
        id: "2",
        processedAt : "Dec 02, 2018",
        orderNumber: 4,
        address: getMockAddress(1),
        orderProducts: await getMockOrderProducts()));

    orders.add(new Order(
        id: "3",
        processedAt : "Dec 03, 2018",
        orderNumber: 3,
        address: getMockAddress(2),
        orderProducts: await getMockOrderProducts()));

    orders.add(new Order(
        id: "4",
        processedAt : "Dec 04, 2018",
        orderNumber: 4,
        address: getMockAddress(3),
        orderProducts: await getMockOrderProducts()));

    return orders;
  }

  static List<Address> getMockAddresses() {
    List<Address> address = new List();

    address.add(getDummyAddress());

    address.add(new Address(
        id: "2",
        address: "Flat No. 8/16/12",
        secondAddress: "Andhra Bank Layout",
        city: "Visakhapatnam",
/*state : "AP",*/ country: "India",
        firstName: "user",
        lastName: "B",
        zip: "123456",
        phone: "1234567890"));

    address.add(new Address(
        id: "3",
        address: "Flat No. 8/16/12",
        secondAddress: "Jai Andhra Layout",
        city: "Hyderabad",
/*state : "TS",*/ country: "India",
        firstName: "user",
        lastName: "C",
        zip: "234561",
        phone: "2345678901"));

    address.add(new Address(
        id: "4",
        address: "Flat No. 8/16/12",
        secondAddress: "Lawyers Layout",
        city: "Ongole",
/*state : "AP",*/ country: "India",
        firstName: "user",
        lastName: "D",
        zip: "345612",
        phone: "3456789012"));

    address.add(new Address(
        id: "5",
        address: "Flat No. 3/4/12",
        secondAddress: "CR Layout",
        city: "Vijayawada",
/*state : "AP",*/ country: "India",
        firstName: "Employee",
        lastName: "E",
        zip: "456123",
        phone: "4567890123"));

    return address;
  }

  static Address getDummyAddress() {
    Address address1 = new Address();
    address1.id = "1";
    address1.address = "Flat No. 33,16/12";
    address1.secondAddress = "Vijaya Bank Layout";
    address1.city = "Bangalore";
    address1.state = "Karnataka";
    address1.country = "India";
    address1.firstName = "user";
    address1.lastName = "A";
    address1.zip = "560076";
    address1.phone = "910123456789";
    return address1;
  }

  static Address getMockAddress(int index) {
    List<Address> addresses = getMockAddresses();

    Address address = new Address();

    address.id = addresses[index].id;
    address.address = addresses[index].address;
    address.secondAddress = addresses[index].secondAddress;
    address.city = addresses[index].city;
    address.state = addresses[index].state;
    address.country = addresses[index].country;
    address.firstName = addresses[index].firstName;
    address.lastName = addresses[index].lastName;
    address.zip = addresses[index].zip;
    address.phone = addresses[index].phone;

    return address;
  }

  static Future<List<OrderProduct>> getMockOrderProducts() async {
    List<OrderProduct> orderProducts = new List();

    orderProducts.add(new OrderProduct(
        title: "1", productVariant: getMockProductVariant(), quantity: 1));

    orderProducts.add(new OrderProduct(
        title: "2", productVariant: getMockProductVariant(), quantity: 2));

    orderProducts.add(new OrderProduct(
        title: "3", productVariant: getMockProductVariant(), quantity: 3));

    orderProducts.add(new OrderProduct(
        title: "4", productVariant: getMockProductVariant(), quantity: 4));

    return orderProducts;
  }

  static ProductVariant getMockProductVariant() {
    ProductVariant productVariant = new ProductVariant();

    productVariant.id = "123";
    productVariant.title = "Olive";
    productVariant.price = 45.0;
    productVariant.isAvailable = true;
// productVariant.selectedOptions = "";
    productVariant.image = new ImageDTO();
    productVariant.productImage = new ImageDTO();
    productVariant.image.src = "https://cdn.shopify.com/s/files/1/0083/1664/9531/products/snowpeak_headlamp_458e50f4-a354-423e-ad48-a83c47878792.jpg?v=1534769365";
    productVariant.productImage.src = "https://cdn.shopify.com/s/files/1/0083/1664/9531/products/snowpeak_headlamp_458e50f4-a354-423e-ad48-a83c47878792.jpg?v=1534769365";
    productVariant.productId = "eyJsYXN0X2lkIjoxNDc4MTY4OTY5Mjc1LCJsYXN0X3ZhbHVlIjoiMCJ9";

    return productVariant;
  }
  ////////////////////////// SHARE AND EARN ////////////////////////////////

  static int getMockMinOrderToAvailEarning() {
    return 200;
  }

  static int getMockTotalEarning() {
    return 150;
  }

  static String getMockMessageToShare() {
    return 'Hello, \n\n Please check this following link for wide '
        'range of Organic products at an afforable price range.\n\nRegards '
        '\nTOW.';
  }

//////////////////////// CUSTOMER SERVICE ////////////////////////////////

  static String getMockCustomerServiceEmail() {
    return "hello@theorganicworld.com";
  }

  static String getMockCustomerServiceNumber() {
    return "08026581708";
  }

/////////////////////////////// ABOUT ////////////////////////////////////

  static String getMockAboutTow() {
    return " The Organic World was started with the mission "
        "to make a positive and progressive difference to the world we live "
        "in. Locally sourced and organically grown produce benefit individuals "
        "and communities. And these not only improve a person’s general well "
        "being but also bring in socio-economic benefits working its way up "
        "from the grassroots level. \n\n The company was launched in 2013 to "
        "give customers the most remarkable organic shopping experience for "
        "all your daily needs from beans to jeans and bathing soaps to "
        "cushion covers. Innovation has always been the companion of all our "
        "ventures and we see no reason to make an exception at The "
        "Organic World. \n\n Organic Products are often associated only with "
        "fruits & vegetables, grocery and dairy & farm products. However, "
        "there is a lot more to organic living than just consuming organic "
        "food products. We aim to introduce a whole new dimension of organic "
        "retail to our customers through apparel, home needs and personal "
        "care products. Choose Better - two words that sum up our principal "
        "intention.";
  }
}