import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String brand;
  final String category;
  final String description;
  final double discountPercentage;
  final int id;
  final List images;
  final int price;
  final double rating;
  final int stock;
  final String thumbnail;
  final String title;

  const Product({
    required this.brand,
    required this.category,
    required this.description,
    required this.discountPercentage,
    required this.id,
    required this.images,
    required this.price,
    required this.rating,
    required this.stock,
    required this.thumbnail,
    required this.title,
  });

  factory Product.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data() as Map<String, dynamic>? ?? {};
    return Product(
      brand: data['brand'] as String? ?? 'No Brand', // Default value if 'brand' is null
      category: data['category'] as String? ?? '',
      description: data['description'] as String? ?? '',
      discountPercentage: data['discountPercentage'] as double? ?? 0.0,
      id: data['id'] as int? ?? 0,
      images: data['images'] as List<dynamic>? ?? [],
      price: data['price'] as int? ?? 0,
      rating: (data['rating'] as num? ?? 0).toDouble(),
      stock: data['stock'] as int? ?? 0,
      thumbnail: data['thumbnail'] as String? ?? '',
      title: data['title'] as String? ?? '',
    );
  }
}
