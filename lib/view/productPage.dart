import 'package:flutter/material.dart';
import 'package:machn_tst/models/product.dart';
import 'package:machn_tst/view/widgets/staticproductCard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductPage extends StatefulWidget {
  ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<List<Product>>? _products;

  @override
  void initState() {
    super.initState();
    print('hiiiiiiiiiiii');
    _products = _fetchProducts();
  }

  Future<List<Product>> _fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://143.198.61.94:8000/api/products'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final products = jsonData['data']
          .cast<
              Map<String,
                  dynamic>>() // Cast each JSON object to Map<String, dynamic>
          .map<Product>((jsonProduct) => Product.fromJson(jsonProduct))
          .toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          'Product List',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 26,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        actions: [
          Stack(
            children: [
              ElevatedButton(
                onPressed: () {},
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
                    onPressed: () {},
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
      ),
      body: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 20,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: snapshot.data![index],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
