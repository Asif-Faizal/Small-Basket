import 'package:flutter/material.dart';

class WishlistCard extends StatelessWidget {
  const WishlistCard({
    super.key,
  });

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
                                'name',
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
                                    '10',
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
                                onPressed: () {},
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
                          onPressed: () {},
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
            height: 80,
            width: 80,
            child: Image.network(
                'https://atlas-content-cdn.pixelsquid.com/stock-images/small-bottle-of-milk-rv2NEl2-600.jpg'),
          ),
        ),
      ],
    );
  }
}
