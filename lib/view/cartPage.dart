import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:machn_tst/view/customerPage.dart';
import 'package:machn_tst/view/widgets/cartCard.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
          'My Cart',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 26,
          ),
        ),
        actions: [
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
              Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        '0',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: 15,
              itemBuilder: (context, index) {
                return const CartCard();
              }),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(79, 98, 142, 47),
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
                            'Sub Total',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16),
                          ),
                          Text(
                            '\$65',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 26),
                          ),
                        ],
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            backgroundColor: Color.fromARGB(115, 70, 117, 17),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomerPage()));
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            child: Text(
                              'CHECKOUT NOW',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
