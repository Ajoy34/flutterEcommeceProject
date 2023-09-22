import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/business_logics/controllers/cart_controller.dart';
import 'package:ecommerce/business_logics/controllers/favourite_controller.dart';

import 'package:ecommerce/const/app_colors.dart';
import 'package:ecommerce/model/cart.dart';

import 'package:ecommerce/model/products.dart';
import 'package:ecommerce/model/user_favourite.dart';


import 'package:ecommerce/ui/route/route.dart';
import 'package:ecommerce/ui/services/firestore_db.dart';
import 'package:ecommerce/ui/style/app_styles.dart';
import 'package:ecommerce/ui/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: RefreshIndicator(
          onRefresh: () => FirestoreDB().getProducts(),
          child: FutureBuilder(
            future: FirestoreDB().getProducts(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      itemCount: snapshot.data!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.85),
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () => Get.toNamed(details,
                              arguments: snapshot.data![index]),
                          child: Ink(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.grayColor.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 3))
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: snapshot.data![index].thumbnail,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, progress) => Center(
                                    child: CircularProgressIndicator(
                                      value: progress.progress,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                Text(
                                  snapshot.data![index].title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  '\$ ${snapshot.data![index].price.toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return Center(child: Text('something went wrong'));
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}






class DetailsScreen extends StatefulWidget {
  Product data;
  DetailsScreen({super.key, required this.data});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mandarinColor,
        actions: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirestoreDB().checkFavourite(widget.data.id),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return IconButton(
                    onPressed: () async {
                      final favouriteData = UserFavourite(
                          brand: widget.data.brand,
                          category: widget.data.category,
                          description: widget.data.description,
                          discountPercentage: widget.data.discountPercentage,
                          id: widget.data.id,
                          images: widget.data.images,
                          price: widget.data.price,
                          rating: widget.data.rating,
                          stock: widget.data.stock,
                          thumbnail: widget.data.thumbnail,
                          title: widget.data.title);
                      if (snapshot.data!.docs.isEmpty) {
                        await FirestoreDB().addToFavourite(favouriteData);
                        Get.find<FavoruiteController>()
                            .fetch();
                      } else {
                        Get.showSnackbar(
                            AppStyles().failedSnacBar('Already Added'));
                      }
                    },
                    icon: snapshot.data!.docs.isEmpty
                        ? Icon(Icons.favorite_outline)
                        : Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ));
              })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.data.images
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.only(top: 10, left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: AppColors.mandarinColor, width: 5)),
                        child: CachedNetworkImage(
                          imageUrl: e,
                          height: 100,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, progress) =>
                              Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    )
                    .toList(),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.data.description,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.grayColor),
                ),
                Text(
                  widget.data.category,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.blue),
                ),
                Text(
                  'Discount- ${widget.data.discountPercentage.toString()}%',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
                Text(
                  'Stock- ${widget.data.stock.toString()}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(
                  'Rating- ${widget.data.rating.toString()}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                Text(
                  'Price- \$ ${widget.data.price.toString()}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mandarinColor),
                ),
                customButton('Add to Cart', () async {
                  final cartData = UserCart(
                      brand: widget.data.brand,
                      category: widget.data.category,
                      description: widget.data.description,
                      discountPercentage: widget.data.discountPercentage,
                      id: widget.data.id,
                      images: widget.data.images,
                      price: widget.data.price,
                      rating: widget.data.rating,
                      stock: widget.data.stock,
                      thumbnail: widget.data.thumbnail,
                      title: widget.data.title);
                  await FirestoreDB().addToCart(cartData);
                  Get.find<CartController>().fetch();
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}