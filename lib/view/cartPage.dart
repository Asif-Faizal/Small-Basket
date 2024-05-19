import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:machn_tst/repository/productAdapter.dart';
import 'package:machn_tst/view/customerPage.dart';
import 'package:machn_tst/view/widgets/cartCard.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Box<Product> _cartBox;
  List<Product> products = [];
  Map<Product, int> productQuantities = {};

  @override
  void initState() {
    super.initState();
    _openCartBox();
  }

  Future<void> _openCartBox() async {
    _cartBox = await Hive.openBox<Product>('cart');
    _loadCartProducts();
    _cartBox.watch().listen((event) {
      _loadCartProducts();
    });
  }

  Future<void> _loadCartProducts() async {
    try {
      products = _cartBox.values.toList();
      productQuantities = {
        for (var product in products) product: 1,
      };
      setState(() {});
    } catch (e) {
      print("Error loading cart products: $e");
    }
  }

  double calculateSubTotal() {
    double subTotal = 0;
    for (var product in products) {
      subTotal += product.price * (productQuantities[product] ?? 1);
    }
    return subTotal;
  }

  void _updateQuantity(Product product, int quantity) {
    setState(() {
      productQuantities[product] = quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: products.isEmpty
            ? Center(child: Text('Your cart is empty!'))
            : BottomAppBar(
                color: Colors.transparent,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(156, 131, 204, 48),
                      ),
                      height: 100,
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '\$${calculateSubTotal().toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 26,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(115, 94, 163, 14),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomerPage(),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 15,
                              ),
                              child: Text(
                                'CHECKOUT NOW',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 26,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/wishlist');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
            ),
            child: Icon(
              Icons.favorite,
              size: 24,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
      body: products.isEmpty
          ? Center(child: Text('Your cart is empty!'))
          : Stack(
              children: [
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(15),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return CartCard(
                      product: products[index],
                      onQuantityChanged: (quantity) {
                        _updateQuantity(products[index], quantity);
                      },
                    );
                  },
                ),
              ],
            ),
    );
  }
}
