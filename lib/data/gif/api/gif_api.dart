import 'package:dio/dio.dart';
import '../model/gif_response.dart';

class GifApiClient {
  final Dio _dio;

  GifApiClient(this._dio);

  static const _apiKey = String.fromEnvironment("apiKey");

  Future<GifResponse> searchGifs({
    required String lang,
    required String query,
    required int offset,
    required int limit,
  }) async {

    final response = await _dio.get(
      '/search?api_key=$_apiKey&rating=pg&q=$query&offset=$offset&limit=$limit&lang=$lang',
    );
    return GifResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<GifResponse> trendingGifs({
    required String lang,
    required String query,
    required int offset,
    required int limit,
  }) async {
    final response = await _dio.get(
      '/trending?api_key=$_apiKey&rating=pg&offset=$offset&limit=$limit&lang=$lang',
    );
    return GifResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
