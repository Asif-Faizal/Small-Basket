import 'package:hive/hive.dart';
import 'package:machn_tst/repository/productAdapter.dart';

class CartRepository {
  static Box<Product>? cartBox;

  static Future<Box<Product>?> getCartBox() async {
    cartBox ??= await Hive.openBox<Product>('cart');
    return cartBox;
  }

  static Future<void> addToCart(Product product) async {
    final cartBox = await getCartBox();
    cartBox?.add(product);
  }

  static Future<void> removeFromCart(int productId) async {
    final cartBox = await getCartBox();
    cartBox?.delete(productId);
  }

  static Future<List<Product>> getCartItems() async {
    final cartBox = await getCartBox();
    return cartBox!.values.toList();
  }
}
