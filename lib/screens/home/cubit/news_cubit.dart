import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_project/models/some_news.dart';

import 'package:news_project/repositories/news.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository _repository;
  NewsCubit(this._repository)
      : super(NewsState(
          status: NewsStatus.initial,
          items: [],
          categories: [
            'All',
            'Business',
            'Sport',
            'Video',
          ],
          selectedCategory: 'All',
        ));

  Future<void> fetch() async {
    emit(state.copyWith(status: NewsStatus.loading));
    try {
      final items = await _repository.fetch(state.selectedCategory);
      emit(state.copyWith(status: NewsStatus.loaded, items: items));
    } catch(error) {
      print(error);
      if (error is DioException) {
        print(error.response?.data);
        emit(state.copyWith(status: NewsStatus.error));
      }
    }
  }

  void selectedCategory(String value) async {
    emit(state.copyWith(selectedCategory: value));
    fetch();
  }
}
