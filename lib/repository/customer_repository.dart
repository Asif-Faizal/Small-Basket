import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:machn_tst/models/customer.dart';

abstract class CustomerRepository {
  Future<List<Customer>> fetchCustomers({String query});
}

class CustomerRepositoryImpl implements CustomerRepository {
  final http.Client _client;

  CustomerRepositoryImpl(this._client);

  @override
  Future<List<Customer>> fetchCustomers({String query = ''}) async {
    final url = Uri.parse(
        'http://143.198.61.94:8000/api/customers/?search_query=$query');
    final request = _client.get(url);

    try {
      final response = await request.timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final customers = jsonData['data']
            .cast<Map<String, dynamic>>()
            .map<Customer>((jsonCustomer) => Customer.fromJson(jsonCustomer))
            .toList();
        return customers;
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
