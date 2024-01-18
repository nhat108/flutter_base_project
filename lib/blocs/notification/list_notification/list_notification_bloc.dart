import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/home/notification/notification_model.dart';
import 'package:minakomi/export.dart';
part 'list_notification_event.dart';
part 'list_notification_state.dart';

class ListNotificationBloc
    extends Bloc<ListNotificationEvent, ListNotificationState> {
  ListNotificationBloc() : super(ListNotificationState.empty()) {
    on<GetListNotification>(_getListNotification);
    on<LoadMoreListNotification>(_loadMoreListNotification);
    on<ReadAllNotification>(_readAllNotification);
  }

  void _getListNotification(
      GetListNotification event, Emitter<ListNotificationState> emit) async {
    try {
      emit(state.copyWith(
        getListNotificationLoading: true,
        getListNotificationError: '',
        page: 1,
      ));
      // // final model = await notificattionRepositories.getListNotification();
      // emit(state.copyWith(
      //   getListNotificationLoading: false,
      //   hasReachedMax: model.next == null,
      //   listNotifications: model.results,
      // ));
    } catch (e) {
      emit(state.copyWith(
        getListNotificationError: e.parseErrorMessage(),
        getListNotificationLoading: false,
      ));
    }
  }

  void _loadMoreListNotification(LoadMoreListNotification event,
      Emitter<ListNotificationState> emit) async {
    if (!state.getListNotificationLoading! && !state.hasReachedMax!) {
      try {
        //  emit(state.copyWith(
        //   getListNotificationLoading: true,
        // ));
        // final model = await notificattionRepositories.getListNotification(
        //   page: state.page! + 1,
        // );
        // emit(state.copyWith(
        //     getListNotificationLoading: false,
        //     hasReachedMax: model.next == null,
        //     page: state.page! + 1,
        //     listNotifications: state.listNotifications! + model.results!));
      } catch (e) {
        emit(state.copyWith(
          getListNotificationError: e.parseErrorMessage(),
          getListNotificationLoading: false,
        ));
      }
    }
  }

  FutureOr<void> _readAllNotification(
      ReadAllNotification event, Emitter<ListNotificationState> emit) async {
    try {
      //  await notificattionRepositories.readAllNotification();
      // emit(state.copyWith(
      //     listNotifications: state.listNotifications!.map((e) {
      //   return e.copyWith(isRead: true);
      // }).toList()));
    } catch (e) {}
  }
}
