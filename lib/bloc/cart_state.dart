import 'package:equatable/equatable.dart';
import 'package:machn_tst/repository/productAdapter.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductsLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<Product> products;

  ProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductsError extends ProductState {
  final String error;

  ProductsError(this.error);

  @override
  List<Object> get props => [error];
}
