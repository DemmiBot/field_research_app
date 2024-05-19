import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavBloc() : super(InitialIndex()) {
    on<IndexChangedEvent>((event, emit) {
      emit(CurrentIndex(currentIndex: event.newIndex));
    });
  }

  static BottomNavItem toEnum(int value) {
    switch (value) {
      case 0:
        return BottomNavItem.survey;

      case 1:
        return BottomNavItem.settings;

      case 2:
        return BottomNavItem.profile;

      default:
        return BottomNavItem.survey;
    }
  }

  static int toInt(BottomNavItem value) {
    switch (value) {
      case BottomNavItem.survey:
        return 0;

      case BottomNavItem.settings:
        return 1;

      case BottomNavItem.profile:
        return 2;

      default:
        return 0;
    }
  }
}
