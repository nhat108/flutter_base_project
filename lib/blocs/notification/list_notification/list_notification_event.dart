part of 'list_notification_bloc.dart';

abstract class ListNotificationEvent extends Equatable {
  const ListNotificationEvent();

  @override
  List<Object> get props => [];
}

class GetListNotification extends ListNotificationEvent {}

class LoadMoreListNotification extends ListNotificationEvent {
  const LoadMoreListNotification();
}

class ReadAllNotification extends ListNotificationEvent {}
