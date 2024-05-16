import 'package:flutter/material.dart';

class AppbarActions extends StatelessWidget {
  const AppbarActions({
    super.key,
  });

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
            ))
      ],
    );
  }
}
