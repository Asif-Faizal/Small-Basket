import 'package:flutter/material.dart';
import 'package:machn_tst/models/product.dart';
import 'package:machn_tst/view/widgets/productCard.dart';

class ProductPage extends StatefulWidget {
  ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Product> products = [
    Product(
        id: 'h1',
        name: "Product 1",
        price: 29.99,
        imageUrl:
            "https://atlas-content-cdn.pixelsquid.com/stock-images/small-bottle-of-milk-rv2NEl2-600.jpg"),
    Product(
        id: 'h2',
        name: "Product 1",
        price: 29.99,
        imageUrl:
            "https://atlas-content-cdn.pixelsquid.com/stock-images/small-bottle-of-milk-rv2NEl2-600.jpg"),
    Product(
        id: 'h3',
        name: "Product 1",
        price: 29.99,
        imageUrl:
            "https://atlas-content-cdn.pixelsquid.com/stock-images/small-bottle-of-milk-rv2NEl2-600.jpg"),
    Product(
        id: 'h4',
        name: "Product 2",
        price: 39.99,
        imageUrl:
            "https://atlas-content-cdn.pixelsquid.com/stock-images/small-bottle-of-milk-rv2NEl2-600.jpg"),
    Product(
        id: 'h1',
        name: "Product 1",
        price: 29.99,
        imageUrl:
            "https://atlas-content-cdn.pixelsquid.com/stock-images/small-bottle-of-milk-rv2NEl2-600.jpg"),
    Product(
        id: 'h2',
        name: "Product 1",
        price: 29.99,
        imageUrl:
            "https://atlas-content-cdn.pixelsquid.com/stock-images/small-bottle-of-milk-rv2NEl2-600.jpg"),
    Product(
        id: 'h3',
        name: "Product 1",
        price: 29.99,
        imageUrl:
            "https://atlas-content-cdn.pixelsquid.com/stock-images/small-bottle-of-milk-rv2NEl2-600.jpg"),
    Product(
        id: 'h4',
        name: "Product 2",
        price: 39.99,
        imageUrl:
            "https://atlas-content-cdn.pixelsquid.com/stock-images/small-bottle-of-milk-rv2NEl2-600.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(product: products[index]);
          },
        ),
      ),
    );
  }
}
