import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:machn_tst/models/product.dart';
import 'package:machn_tst/view/ddetailsPage.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(product: product)));
      },
      child: Stack(
        children: [
          SizedBox(
            height: 170,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 150,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
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
                                  _addToCart(product);
                                  getCartProducts();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          action: SnackBarAction(
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                              label: 'undo',
                                              onPressed: () {
                                                _undo(product);
                                              }),
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            '1kg ${product.name} added to Cart',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )));
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
              left: 25,
              child: Image.network(
                'http://143.198.61.94:8000${product.imageUrl}',
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              )),
          Positioned(
              top: 30,
              right: 10,
              child: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.error,
              )),
        ],
      ),
    );
  }

  void _addToCart(Product product) async {
    print(
        '========================================added ${product.name} to cart==============================================');
    var box = await Hive.openBox<Product>('cart');
    box.add(product);
  }

  void _undo(Product product) async {
    print(
        '========================================undo ${product.name} from cart==============================================');
    var box = await Hive.openBox<Product>('cart');
    box.delete(product);
  }

  Future<List<Product>> getCartProducts() async {
    var box = await Hive.openBox<Product>('cart');
    List<Product> products = box.values.toList();
    print(
        '=========================================added to hive ${product.name}===============================================');
    return products;
  }
}
