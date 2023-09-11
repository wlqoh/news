import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news_project/models/some_news.dart';

class NewsRepository {
  final String _url = '/v2/top-headlines';

  Future<List<SomeNews>> fetch(String selected) async {
    final dio = Dio(BaseOptions(baseUrl: 'https://newsapi.org'));
    dio.interceptors.add(
      InterceptorsWrapper(onResponse: (response, handler) {
        logResponse(response: response);
        return handler.next(response);
      }, onError: (error, handler) async {
        logResponse(error: error);
        return handler.next(error);
      }),
    );
    final List<SomeNews> news = [];

    final response = await dio.get(_url, queryParameters: {
      'apiKey': "67907167b49940f3aa7378f63f3bbca4",
      'q': selected.toLowerCase(),
    });
    for (final item in response.data['articles']) {
      news.add(SomeNews.fromJson(item));
    }
    return news;
  }
}

void logResponse({Response? response, DioException? error}) {
  final r = response ?? error?.response;
  final RequestOptions options = r?.requestOptions ?? error!.requestOptions;
  final shortUri = r?.realUri ?? options.uri;
  final shortUrl = shortUri.toString().replaceAll(options.baseUrl, "");
  var output = "${options.method}"
      "${r?.statusCode} "
      "$shortUrl";

  final statusCode = r?.statusCode ?? 0;
  if (statusCode >= 400 && statusCode <= 499) {
    output += " ${r?.data}";
  }
  log(output);
}
