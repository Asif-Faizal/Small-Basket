import 'package:flutter/material.dart';
import 'package:machn_tst/repository/cart_repositiry.dart';
import 'package:machn_tst/repository/productAdapter.dart';
import 'package:machn_tst/repository/wishlist_repository.dart';
import 'package:machn_tst/view/ddetailsPage.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = true;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    bool favoriteStatus =
        await WishRepository.isProductInWishlist(widget.product);
    setState(() {
      isFavorite = favoriteStatus;
    });
  }

  void _toggleFavorite() async {
    if (isFavorite) {
      await WishRepository.removeFromWish(widget.product.id);
    } else {
      await WishRepository.addToWish(widget.product);
    }
    setState(() {
      isFavorite = !isFavorite;
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
            height: 170,
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 150,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
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
                                    widget.product.name,
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
                                        '\$${widget.product.price.toStringAsFixed(2)}',
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
                                  const SizedBox(height: 10),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await CartRepository.addToCart(
                                      widget.product);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.surface,
                                      action: SnackBarAction(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        label: 'undo',
                                        onPressed: () async {
                                          await CartRepository.removeFromCart(
                                              widget.product.id);
                                        },
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                        '1kg ${widget.product.name} added to Cart',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
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
              'http://143.198.61.94:8000${widget.product.imageUrl}',
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).colorScheme.error,
              ),
              onPressed: _toggleFavorite,
            ),
          ),
        ],
      ),
    );
  }
}
