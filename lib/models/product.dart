import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String imageUrl;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl});
}
