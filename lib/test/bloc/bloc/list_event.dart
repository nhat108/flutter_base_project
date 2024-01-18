part of 'list_bloc.dart';

abstract class ListEvent {}

class GetList extends ListEvent {
  final bool isLoadMore;

  GetList({required this.isLoadMore});
}
