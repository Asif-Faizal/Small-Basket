import 'package:bloc/bloc.dart';
import 'package:machn_tst/bloc/bottom_nav_event.dart';
import 'package:machn_tst/bloc/bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavInitial());

  Stream<BottomNavState> mapEventToState(BottomNavEvent event) async* {
    if (event is UpdateBottomNavIndex) {
      yield BottomNavIndexUpdated(event.newIndex);
    }
  }
}
