import 'package:jvanila_flutter/jvanila.dart';

class TowInjector extends Injector {

  TowInjector(ApplicationContext context) : super(context);

  RepositoryFactory newRepoFactory() {
    return null;//new TowRepoFactory();
  }

  @override
  void injectApisOnAppCreate() {
    super.injectApisOnAppCreate();
    /*context.apis['EcommerceApi'] = new GoFrugal(context, domainPath: 'TBF',
      authToken: 'TBF',);*/

//    context.apis = new Map();
//    context.apis['EcommerceApi'] = new MockCommerceApi();
  }
}