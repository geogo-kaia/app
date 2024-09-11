import 'package:equatable/equatable.dart';

abstract class TabBarState extends Equatable {
  const TabBarState();

  @override
  List<Object> get props => [];
}

class NavigationState extends TabBarState{
  final int index;
  const NavigationState(this.index);

  @override
  List<Object> get props => [index];
}
