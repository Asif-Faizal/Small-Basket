import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:machn_tst/repository/productAdapter.dart';

class ApiService {
  static const String apiUrl = 'http://143.198.61.94:8000/orders';

  Future<http.Response> placeOrder(
      int customerId, double totalPrice, List<Product> products) async {
    final List<Map<String, dynamic>> productList = products
        .map((product) => {
              'product_id': product.id,
              'quantity': 1,
              'price': product.price,
            })
        .toList();

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'customer_id': customerId,
        'total_price': totalPrice,
        'products': productList,
      }),
    );

    return response;
  }
}
