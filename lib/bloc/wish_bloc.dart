import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machn_tst/bloc/wish_event.dart';
import 'package:machn_tst/bloc/wish_state.dart';

import '../repository/wishlist_repository.dart';

class WishBloc extends Bloc<WishEvent, WishState> {
  final WishRepository repository;

  WishBloc(this.repository) : super(WishInitial());

  Stream<WishState> mapEventToState(WishEvent event) async* {
    if (event is WishProducts) {
      yield WishLoading();
      try {
        // final products = await repository.fetchProducts();
        // yield ProductsLoaded(products);
      } catch (e) {
        yield WishError(e.toString());
      }
    }
  }
}
