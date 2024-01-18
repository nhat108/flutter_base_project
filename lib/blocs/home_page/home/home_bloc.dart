import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.empty()) {
    on<ChangeMenuItem>(_changeMenuItemIndex);
  }

  _changeMenuItemIndex(ChangeMenuItem event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
      currentMenuItem: event.type,
      data: event.data,
    ));
  }
}
