import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:machn_tst/repository/productAdapter.dart';
import 'package:machn_tst/view/ddetailsPage.dart';

class CartCard extends StatefulWidget {
  final Product product;
  final ValueChanged<int> onQuantityChanged;

  const CartCard({
    Key? key,
    required this.product,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      if (_counter < 9) {
        _counter++;
        widget.onQuantityChanged(_counter);
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) {
        _counter--;
        widget.onQuantityChanged(_counter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(product: widget.product),
          ),
        );
      },
      child: Stack(
        children: [
          SizedBox(
            height: 100,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Stack(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(width: 65, height: 60),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.product.name,
                                    style: TextStyle(
                                      overflow: TextOverflow.clip,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Text(
                                        widget.product.price.toStringAsFixed(0),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                      Text(
                                        '/kg',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildCounterButton(
                                  context,
                                  icon: Icons.remove_rounded,
                                  onPressed: _decrementCounter,
                                ),
                                SizedBox(
                                  width: 5,
                                  child: Center(
                                    child: Text(
                                      _counter.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ),
                                _buildCounterButton(
                                  context,
                                  icon: Icons.add_rounded,
                                  onPressed: _incrementCounter,
                                  isIncrement: true,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 50,
                              child: Text(
                                '\$${(widget.product.price * _counter).toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -6,
                      right: -6,
                      child: IconButton(
                        onPressed: () {
                          _deleteProduct(widget.product);
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 15,
            top: 20,
            child: SizedBox(
              height: 50,
              width: 50,
              child: Image.network(
                'http://143.198.61.94:8000${widget.product.imageUrl}',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
    bool isIncrement = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isIncrement
            ? Theme.of(context).colorScheme.secondary
            : Colors.white,
        shape: const CircleBorder(),
        side: BorderSide(
          width: 1.5,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      child: Icon(
        icon,
        size: 16,
        color: isIncrement
            ? Colors.white
            : Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  void _deleteProduct(Product product) async {
    var box = await Hive.openBox<Product>('cart');
    var index = box.values.toList().indexOf(product);
    if (index != -1) {
      box.deleteAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${product.name} removed from cart')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${product.name} not found in cart')),
      );
    }
  }
}
