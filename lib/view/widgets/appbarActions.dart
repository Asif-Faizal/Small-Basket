import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:machn_tst/repository/productAdapter.dart';

import '../../repository/cart_repositiry.dart';

class AppbarActions extends StatefulWidget {
  const AppbarActions({super.key});

  @override
  _AppbarActionsState createState() => _AppbarActionsState();
}

class _AppbarActionsState extends State<AppbarActions> {
  int _itemCount = 0;
  late Box<Product> _cartBox;

  @override
  void initState() {
    super.initState();
    _fetchItemCount();
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/wishlist');
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10)),
              child: Icon(
                Icons.favorite,
                size: 28,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
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
    );
  }
}
