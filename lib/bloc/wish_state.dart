import 'package:equatable/equatable.dart';
import 'package:machn_tst/repository/productAdapter.dart';

abstract class WishState extends Equatable {
  @override
  List<Object> get props => [];
}

class WishInitial extends WishState {}

class WishLoading extends WishState {}

class WishLoaded extends WishState {
  final List<Product> products;

  WishLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class WishError extends WishState {
  final String error;

  WishError(this.error);

  @override
  List<Object> get props => [error];
}
