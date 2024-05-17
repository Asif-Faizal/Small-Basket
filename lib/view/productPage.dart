import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machn_tst/bloc/product_bloc.dart';
import 'package:machn_tst/bloc/product_event.dart';
import 'package:machn_tst/bloc/product_state.dart';
import 'package:machn_tst/models/product.dart';
import 'package:machn_tst/repository/product_repository.dart';
import 'package:machn_tst/view/widgets/appbarActions.dart';
import 'package:machn_tst/view/widgets/myDrawer.dart';
import 'package:machn_tst/view/widgets/productCard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductPage extends StatefulWidget {
  ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<List<Product>> _fetchProducts() async {
    final client = http.Client();
    final request =
        client.get(Uri.parse('http://143.198.61.94:8000/api/products'));

    try {
      final response = await request.timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final products = jsonData['data']
            .cast<Map<String, dynamic>>()
            .map<Product>((jsonProduct) => Product.fromJson(jsonProduct))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Timed Out');
      } else {
        throw Exception('Failed to load products');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.secondary,
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
        actions: const [AppbarActions()],
      ),
      body: BlocProvider(
        create: (context) => ProductBloc(ProductRepositoryImpl(http.Client())),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductInitial) {
              BlocProvider.of<ProductBloc>(context).add(LoadProducts());
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsLoaded) {
              return Container(
                color: Theme.of(context).colorScheme.background,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: state.products[index],
                      );
                    },
                  ),
                ),
              );
            } else if (state is ProductsError) {
              return Center(child: Text(state.error));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
