import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:machn_tst/repository/productAdapter.dart';

import '../../repository/wishlist_repository.dart';

class WishlistCard extends StatefulWidget {
  final Product product;
  const WishlistCard({
    super.key,
    required this.product,
  });

  @override
  State<WishlistCard> createState() => _WishlistCardState();
}

class _WishlistCardState extends State<WishlistCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(
                            width: 60,
                            height: 60,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.product.name,
                                style: TextStyle(
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
                                    widget.product.price.toString(),
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
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.all(10),
                                  side: BorderSide(
                                      width: 1.5,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                                onPressed: () async {
                                  await WishRepository.addToWish(
                                      widget.product);
                                  _delete(widget.product);
                                },
                                child: Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: -5,
                      right: -5,
                      child: IconButton(
                          onPressed: () async {
                            _delete(widget.product);
                            await WishRepository.removeFromWish(
                                widget.product.id);
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 14,
                          )))
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
    );
  }

  void _delete(Product product) async {
    print(
        '========================================Deleted ${product.name} from wish==============================================');
    var box = await Hive.openBox<Product>('wish');
    box.deleteAt(box.values.toList().indexOf(product));
  }
}
