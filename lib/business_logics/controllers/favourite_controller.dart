import 'package:ecommerce/model/user_favourite.dart';

import 'package:ecommerce/ui/services/firestore_db.dart';
import 'package:get/get.dart';

class FavoruiteController extends GetxController {
  RxList<UserFavourite> items = RxList<UserFavourite>([]);

  fetch() async {
    var favItems = await FirestoreDB().getFavouriteItems();
    items.value = favItems;
  }

  @override
  void onInit() {
    fetch();
    super.onInit();
  }
}