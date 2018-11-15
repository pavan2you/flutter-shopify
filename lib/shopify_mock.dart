import 'dart:async';

import 'package:shopify/model/category.dart';
import 'package:shopify/model/image.dart';
import 'package:shopify/model/offer_product.dart';
import 'package:shopify/model/order.dart';
import 'package:shopify/model/product.dart';
import 'package:shopify/shopify_constants.dart';

class MockShopify {

  static Future<List<Order>> getMockOrders(int perPage, dynamic paginationValue) async {

    Map<dynamic, dynamic> args = new Map();
    args[kArgPerPage] = perPage;
    args[kArgPaginationValue] = paginationValue;

    List<Order> orders = new List();
    Order order1 = new Order();
    order1.id = "1";
    order1.processedAt = new DateTime.utc(2018, 10, 03, 09, 18);
    order1.orderNumber = 2; // need to change wrt status
    orders.add(order1);

    Order order2 = new Order();
    order2.id = "2";
    order2.processedAt = new DateTime.utc(2018, 11, 12, 19, 25);;
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
}