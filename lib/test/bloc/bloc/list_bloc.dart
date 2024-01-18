import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:minakomi/api/api.dart';
import 'package:minakomi/models/list_model.dart';
import 'package:equatable/equatable.dart';
import 'package:minakomi/export.dart';
part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(ListState.empty()) {
    on<GetList>(_getList);
  }

  FutureOr<void> _getList(GetList event, Emitter<ListState> emit) async {
    if (event.isLoadMore == false ||
        state.list?.next != null && state.getListLoading == false) {
      try {
        emit(state.copyWith(
          getListLoading: true,
          getListError: '',
        ));
        final model = await TestRepository().getListCategory(
            page: event.isLoadMore ? state.list!.nextPage! : 1);
        emit(state.copyWith(
          getListLoading: false,
          list: event.isLoadMore ? model.addList(model: state.list!) : model,
        ));
      } catch (e) {
        emit(state.copyWith(
          getListError: e.parseErrorMessage(),
          getListLoading: false,
        ));
      }
    }
  }
}

class TestRepository extends Api {
  Future<ListModel<Category>> getListCategory(
      {int page = 1, int pageSize = 10}) async {
    final response = await request(
        "https://dev-api.tipmi.com/api/v1.0/user/interest-categories/",
        Method.get,
        useIDToken: false,
        params: {"page": page, "page_size": pageSize});
    return ListModel.fromJson(response.data, (json) => Category.fromJson(json));
  }
}

class Category extends Equatable {
  final String? id;
  final String? name;

  Category({this.id, this.name});
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [id, name];
}
