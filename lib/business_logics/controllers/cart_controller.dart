import 'package:ecommerce/model/cart.dart';
import 'package:ecommerce/ui/services/firestore_db.dart';

import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<UserCart> items = RxList<UserCart>([]);

  fetch() async {
    var cartItems = await FirestoreDB().getCartItems();
    items.value = cartItems;
  }

  @override
  void onInit() {
    fetch();
    super.onInit();
  }

  int get getTotal =>
      items.fold(0, (previousValue, element) => previousValue + element.price);
}