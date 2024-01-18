part of 'home_bloc.dart';

abstract class HomeEvent {}

class ChangeMenuItem extends HomeEvent {
  final MenuItemType type;
  final String? data;
  ChangeMenuItem({this.data, required this.type});
}
