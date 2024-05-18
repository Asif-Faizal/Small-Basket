import 'package:hive/hive.dart';
import 'package:machn_tst/repository/productAdapter.dart';

class WishRepository {
  static Box<Product>? wishBox;

  static Future<Box<Product>?> getWishBox() async {
    wishBox ??= await Hive.openBox<Product>('wish');
    return wishBox;
  }

  static Future<void> addToWish(Product product) async {
    final wishBox = await getWishBox();
    wishBox?.add(product);
  }

  static Future<void> removeFromWish(int productId) async {
    final wishBox = await getWishBox();
    wishBox?.delete(productId);
  }

  static Future<List<Product>> getWishItems() async {
    final wishBox = await getWishBox();
    return wishBox!.values.toList();
  }

  static Future<bool> isProductInWishlist(Product product) async {
    final wishBox = await WishRepository.getWishBox();
    return wishBox!.values.toList().any((product) => product.id == product.id);
  }
}
