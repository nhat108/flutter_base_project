part of 'list_notification_bloc.dart';

class ListNotificationState extends Equatable {
  final bool? getListNotificationLoading;
  final String? getListNotificationError;
  final List<NotificationModel>? listNotifications;
  final int? page;
  final bool? hasReachedMax;

  const ListNotificationState(
      {this.getListNotificationLoading,
      this.getListNotificationError,
      this.listNotifications,
      this.page,
      this.hasReachedMax});
  factory ListNotificationState.empty() {
    return const ListNotificationState(
      getListNotificationError: '',
      getListNotificationLoading: false,
      hasReachedMax: false,
      listNotifications: [],
      page: 1,
    );
  }
  ListNotificationState copyWith({
    final bool? getListNotificationLoading,
    final String? getListNotificationError,
    final List<NotificationModel>? listNotifications,
    final int? page,
    final bool? hasReachedMax,
  }) {
    return ListNotificationState(
      getListNotificationError:
          getListNotificationError ?? this.getListNotificationError,
      getListNotificationLoading:
          getListNotificationLoading ?? this.getListNotificationLoading,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      listNotifications: listNotifications ?? this.listNotifications,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [
        getListNotificationLoading,
        getListNotificationError,
        listNotifications,
        page,
        hasReachedMax
      ];
}
