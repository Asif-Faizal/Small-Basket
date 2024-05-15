import 'package:equatable/equatable.dart';

abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent();

  @override
  List<Object> get props => [];
}

class UpdateBottomNavIndex extends BottomNavEvent {
  final int newIndex;

  const UpdateBottomNavIndex(this.newIndex);

  @override
  List<Object> get props => [newIndex];
}
