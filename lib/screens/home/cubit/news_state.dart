part of 'news_cubit.dart';

enum NewsStatus {
  initial,
  loading,
  loaded,
  error,
}

class NewsState {
  final NewsStatus _status;
  final List<SomeNews> _items;
  final List<String> _categories;
  final String _selectedCategory;

  NewsState({
    required NewsStatus status,
    required List<SomeNews> items,
    required List<String> categories,
    required String selectedCategory,
  })  : _status = status,
        _items = items,
        _categories = categories,
        _selectedCategory = selectedCategory;

  NewsStatus get status => _status;

  List<SomeNews> get items => _items;

  List<String> get categories => _categories;

  String get selectedCategory => _selectedCategory;

  NewsState copyWith({
    NewsStatus? status,
    List<SomeNews>? items,
    List<String>? categories,
    String? selectedCategory,
  }) {
    return NewsState(
      status: status ?? _status,
      items: items ?? _items,
      categories: categories ?? _categories,
      selectedCategory: selectedCategory ?? _selectedCategory,
    );
  }
}
