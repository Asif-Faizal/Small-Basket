import 'package:equatable/equatable.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object> get props => [];
}

class LoadCustomers extends CustomerEvent {
  final String query;

  const LoadCustomers({this.query = ''});

  @override
  List<Object> get props => [query];
}
