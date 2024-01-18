part of 'list_bloc.dart';

class ListState extends Equatable {
  final bool? getListLoading;
  final ListModel<Category>? list;
  final String? getListError;

  ListState({this.getListLoading, this.list, this.getListError});

  factory ListState.empty() {
    return ListState(
      getListError: '',
      getListLoading: false,
      list: null,
    );
  }
  ListState copyWith({
    final bool? getListLoading,
    final ListModel<Category>? list,
    final String? getListError,
  }) {
    return ListState(
      getListError: getListError ?? this.getListError,
      getListLoading: getListLoading ?? this.getListLoading,
      list: list ?? this.list,
    );
  }

  @override
  List<Object?> get props =>
      [this.getListLoading, this.list, this.getListError];
}
