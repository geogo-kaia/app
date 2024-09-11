import 'package:bloc/bloc.dart';
import 'package:geogo/bloc/TabBarBloc/tabbar_event.dart';
import 'package:geogo/bloc/TabBarBloc/tabbar_state.dart';

class TabBarBloc extends Bloc<TabBarEvent, TabBarState> {
  TabBarBloc() : super(const NavigationState(0)) {
    on<NavigationEvent>(((event, emit) => emit(NavigationState(event.index))));
  }
}
