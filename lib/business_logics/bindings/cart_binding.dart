
import 'package:ecommerce/business_logics/controllers/cart_controller.dart';
import 'package:get/get.dart';

class CartBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(CartController());
  }

}