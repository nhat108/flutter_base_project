import 'package:equatable/equatable.dart';

class ListModel<T> extends Equatable {
  final int? count;
  final String? next;
  final String? previous;
  final List<T>? results;
  final bool? hasReachedMax;
  final int? nextPage;
  const ListModel(
      {this.nextPage,
      this.hasReachedMax,
      this.count,
      this.next,
      this.previous,
      this.results});
  factory ListModel.fromJson(Map<String, dynamic> response,
      T Function(Map<String, dynamic> data) json) {
    int _nextPage = 1;
    if (response['next'] != null) {
      var uri = Uri.parse(response['next']);
      if (uri.queryParameters['page'] != null) {
        _nextPage = int.tryParse(uri.queryParameters['page']!) ?? 1;
      }
    }
    return ListModel(
      count: response['count'],
      next: response['next'],
      previous: response['previous'],
      results:
          (response['results'] as List? ?? []).map((e) => json(e)).toList(),
      hasReachedMax: response['next'] == null,
      nextPage: _nextPage,
    );
  }
  ListModel<T> addList({required ListModel<T> model}) {
    return ListModel(
        count: count,
        hasReachedMax: hasReachedMax,
        next: next,
        nextPage: nextPage,
        previous: previous,
        results: model.results! + this.results!);
  }

  factory ListModel.empty() {
    return ListModel<T>(
        count: null,
        hasReachedMax: true,
        next: null,
        nextPage: null,
        previous: null,
        results: []);
  }

  @override
  List<Object?> get props => [
        this.nextPage,
        this.hasReachedMax,
        this.count,
        this.next,
        this.previous,
        this.results
      ];
}
