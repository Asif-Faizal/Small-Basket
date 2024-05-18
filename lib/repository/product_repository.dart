import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:machn_tst/repository/productAdapter.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProduct();
}

class ProductRepositoryImpl implements ProductRepository {
  final http.Client _client;

  ProductRepositoryImpl(this._client);

  @override
  Future<List<Product>> fetchProduct() async {
    final request =
        _client.get(Uri.parse('http://143.198.61.94:8000/api/products'));

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
        throw Exception('Failed to load Products');
      }
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Timed Out');
      } else {
        throw Exception('Failed to load Products');
      }
    }
  }
}
