import 'package:flutter/material.dart';
import 'package:machn_tst/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 170,
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 130,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      '\$${product.price.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green.shade400,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '/kg',
                                      style: TextStyle(
                                        color: Colors.green.shade400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Add your onPressed logic here
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                              ),
                              child: const Icon(
                                Icons.add_rounded,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
              child: Image.network(
            product.imageUrl,
            height: 100,
            width: 100,
          )),
        ),
        Positioned(
            top: 50,
            right: 10,
            child: Icon(
              Icons.favorite,
              color: Theme.of(context).colorScheme.error,
            )),
      ],
    );
  }
}
