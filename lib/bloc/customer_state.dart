import 'package:machn_tst/models/customer.dart';

abstract class CustomerState {}

class CustomerInitial extends CustomerState {}

class CustomersLoading extends CustomerState {}

class CustomersLoaded extends CustomerState {
  final List<Customer> customers;

  CustomersLoaded(this.customers);
}

class CustomersError extends CustomerState {
  final String error;

  CustomersError(this.error);
}
