import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:machn_tst/models/customer.dart';

abstract class CustomerRepository {
  Future<List<Customer>> fetchCustomers();
}

class CustomerRepositoryImpl implements CustomerRepository {
  final http.Client _client;

  CustomerRepositoryImpl(this._client);

  @override
  Future<List<Customer>> fetchCustomers() async {
    final request =
        _client.get(Uri.parse('http://143.198.61.94:8000/api/customers'));

    try {
      final response = await request.timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final products = jsonData['data']
            .cast<Map<String, dynamic>>()
            .map<Customer>((jsonProduct) => Customer.fromJson(jsonProduct))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load Customers');
      }
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Timed Out');
      } else {
        throw Exception('Failed to load Customers');
      }
    }
  }
}
