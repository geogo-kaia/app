import 'package:equatable/equatable.dart';

abstract class TabBarEvent extends Equatable {
  const TabBarEvent();

  @override
  List<Object> get props => [];
}

class NavigationEvent extends TabBarEvent{
  final int index;
  const NavigationEvent(this.index);

  @override
  List<Object> get props => [index];
}
