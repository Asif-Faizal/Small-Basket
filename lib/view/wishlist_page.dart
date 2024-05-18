import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:machn_tst/repository/cart_repositiry.dart';
import 'package:machn_tst/repository/productAdapter.dart';
import 'package:machn_tst/view/widgets/wishlistCard.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late Box<Product> _wishBox;
  List<Product> products = [];
  int _itemCount = 0;
  late Box<Product> _cartBox;

  @override
  void initState() {
    super.initState();
    _fetchItemCount();
    _openWishBox();
    CartRepository.getCartBox().then((cartBox) {
      _cartBox = cartBox!;
      _cartBox.watch().listen((_) {
        _fetchItemCount();
      });
    });
  }

  Future<void> _fetchItemCount() async {
    setState(() {
      _itemCount = _cartBox.length;
    });
  }

  Future<void> _openWishBox() async {
    _wishBox = await Hive.openBox<Product>('wish');
    _loadWishProducts();
    _wishBox.watch().listen((event) {
      _loadWishProducts();
    });
  }

  Future<void> _loadWishProducts() async {
    try {
      products = _wishBox.values.toList();
      setState(() {});
    } catch (e) {
      print("Error loading cart products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        title: Text(
          'My Wishlist',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 26,
          ),
        ),
        actions: [
          Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Stack(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/cart');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10)),
                        child: Icon(
                          Icons.shopping_cart_rounded,
                          size: 28,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Positioned(
                          top: 5,
                          right: 5,
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.error,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                '$_itemCount',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ],
                  ))
            ],
          ),
        ],
      ),
      body: products.isEmpty
          ? Center(child: Text('Your wishlist is empty!'))
          : Stack(
              children: [
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(15),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return WishlistCard(product: products[index]);
                  },
                ),
              ],
            ),
    );
  }
}
