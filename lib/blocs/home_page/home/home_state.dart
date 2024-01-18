part of 'home_bloc.dart';

enum MenuItemType { home, discover, camera, notification, profile }

class HomeState extends Equatable {
  final MenuItemType? currentMenuItem;
  final String? data;
  const HomeState({this.data, this.currentMenuItem});
  factory HomeState.empty() {
    return const HomeState(
      currentMenuItem: MenuItemType.home,
      data: '',
    );
  }
  HomeState copyWith({
    MenuItemType? currentMenuItem,
    String? data,
  }) {
    return HomeState(
        data: data ?? this.data,
        currentMenuItem: currentMenuItem ?? this.currentMenuItem);
  }

  @override
  List<Object?> get props => [data, currentMenuItem];
}
