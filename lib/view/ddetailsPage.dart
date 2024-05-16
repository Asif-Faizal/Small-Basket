import 'package:flutter/material.dart';
import 'package:machn_tst/models/product.dart';

class DetailsPage extends StatelessWidget {
  final Product product;
  const DetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        title: Text('data'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
