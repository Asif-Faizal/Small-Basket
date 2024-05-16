import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machn_tst/bloc/customer_event.dart';
import 'package:machn_tst/bloc/customer_state.dart';
import 'package:machn_tst/repository/customer_repository.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepository _customerRepository;

  CustomerBloc(this._customerRepository) : super(CustomerInitial()) {
    on<LoadCustomers>((event, emit) async {
      try {
        emit(CustomersLoading());
        final customers = await _customerRepository.fetchCustomers();
        emit(CustomersLoaded(customers));
      } catch (e) {
        emit(CustomersError(e.toString()));
      }
    });
  }
}
