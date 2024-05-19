part of 'bottom_nav_bloc.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
final class IndexChangedEvent extends BottomNavigationEvent {
  BottomNavItem newIndex;

  IndexChangedEvent({required this.newIndex});
}
