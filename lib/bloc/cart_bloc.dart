import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machn_tst/bloc/product_event.dart';
import 'package:machn_tst/bloc/product_state.dart';
import 'package:machn_tst/repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductInitial());

  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is LoadProducts) {
      yield ProductsLoading();
      try {
        // final products = await repository.fetchProducts();
        // yield ProductsLoaded(products);
      } catch (e) {
        yield ProductsError(e.toString());
      }
    }
  }
}
