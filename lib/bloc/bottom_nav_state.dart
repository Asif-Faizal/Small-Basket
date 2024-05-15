import 'package:equatable/equatable.dart';

abstract class BottomNavState extends Equatable {
  const BottomNavState();

  @override
  List<Object> get props => [];
}

class BottomNavInitial extends BottomNavState {}

class BottomNavIndexUpdated extends BottomNavState {
  final int currentIndex;

  const BottomNavIndexUpdated(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
