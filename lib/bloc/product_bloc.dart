import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machn_tst/bloc/product_event.dart';
import 'package:machn_tst/bloc/product_state.dart';
import 'package:machn_tst/repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc(this._productRepository) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      try {
        emit(ProductsLoading());
        final products = await _productRepository.fetchProduct();
        emit(ProductsLoaded(products));
      } catch (e) {
        emit(ProductsError(e.toString()));
      }
    });
  }
}
