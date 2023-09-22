import 'package:ecommerce/business_logics/controllers/auth_controller.dart';
import 'package:ecommerce/business_logics/controllers/splash_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class SplashBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(SplashController());
  }

}