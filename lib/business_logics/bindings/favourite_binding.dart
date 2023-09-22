import 'package:ecommerce/business_logics/controllers/favourite_controller.dart';
import 'package:get/get.dart';

class FavouriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FavoruiteController());
  }
}