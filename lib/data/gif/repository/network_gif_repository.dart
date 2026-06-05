import 'package:giphy_flutter/data/api/gif_api.dart';
import 'package:giphy_flutter/domain/model/gif.dart';
import 'package:giphy_flutter/domain/repository/gif_repository.dart';

class NetworkGifRepository implements GifRepository {
  final GifApiClient _gifApiClient;

  NetworkGifRepository(this._gifApiClient);

  @override
  Future<List<Gif>> getGifs({
    required String lang,
    required String? query,
    required int offset,
    required int limit,
  }) async {
    query = query ?? "";
    final response = await _gifApiClient.searchGifs(lang:lang, query: query, offset: offset, limit: limit);
    return response.data.map((gif) => gif.toGif()).toList();
  }
}
