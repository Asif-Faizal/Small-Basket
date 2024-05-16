import 'package:machn_tst/models/product.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductsLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<Product> products;

  ProductsLoaded(this.products);
}

class ProductsError extends ProductState {
  final String error;

  ProductsError(this.error);
}
