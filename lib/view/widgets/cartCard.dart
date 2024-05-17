import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:machn_tst/models/product.dart';
import 'package:machn_tst/view/ddetailsPage.dart';

class CartCard extends StatefulWidget {
  final Product product;
  const CartCard({
    Key? key,
    required this.product,
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
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) {
        _counter--;
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
                builder: (context) => DetailsPage(product: widget.product)));
      },
      child: Stack(
        children: [
          SizedBox(
            height: 100,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 15),
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(
                              width: 80,
                              height: 60,
                            ),
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
                                            .secondary),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.product.price.toStringAsFixed(0),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                      ),
                                      Text(
                                        '/kg',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _decrementCounter();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: const CircleBorder(),
                                    side: BorderSide(
                                        width: 1.5,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                  child: Icon(
                                    Icons.remove_rounded,
                                    size: 16,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                SizedBox(
                                    width: 3, child: Text(_counter.toString())),
                                ElevatedButton(
                                  onPressed: () {
                                    _incrementCounter();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                    shape: const CircleBorder(),
                                  ),
                                  child: const Icon(
                                    Icons.add_rounded,
                                    size: 16,
                                    color: Colors.white,
                                  ),
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -6,
                      right: -6,
                      child: IconButton(
                        onPressed: () {
                          _delete(widget.product);
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
            left: 20,
            top: 10,
            child: SizedBox(
              height: 60,
              width: 60,
              child: Image.network(
                'http://143.198.61.94:8000${widget.product.imageUrl}',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _delete(Product product) async {
    print(
        '========================================Deleted ${product.name} from cart==============================================');
    var box = await Hive.openBox<Product>('cart');
    box.deleteAt(box.values.toList().indexOf(product));
  }
}
