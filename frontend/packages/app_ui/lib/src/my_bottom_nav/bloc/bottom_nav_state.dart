part of 'bottom_nav_bloc.dart';

enum BottomNavItem { settings, survey, profile, userManager }

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

final class InitialIndex extends BottomNavigationState {
  final BottomNavItem initialIndex = BottomNavItem.survey;
}

final class CurrentIndex extends BottomNavigationState {
  final BottomNavItem currentIndex;

  const CurrentIndex({required this.currentIndex});

  @override
  List<Object> get props => [currentIndex];
}
