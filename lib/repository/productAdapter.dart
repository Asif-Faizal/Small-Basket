import 'package:hive/hive.dart';

part 'productAdapter.g.dart';

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'].toDouble() ?? 0,
      imageUrl: json['image'] ?? '',
    );
  }
}
