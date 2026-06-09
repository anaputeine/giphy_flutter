import 'package:giphy_flutter/domain/gif/model/gif.dart';
import 'package:giphy_flutter/domain/gif/repository/gif_repository.dart';

List<Gif> gifs = List.generate(
  30,
      (i) => Gif(
    id: "$i",
    title: "paper clip claps",
    url: "assets/test.png",
    importDateTime: "2008",
    trendingDateTime: "2008",
  ),
);

class FakeGifRepository implements GifRepository {
  @override
  Future<List<Gif>> getGifs({required String lang, required String? query, required int offset, required int limit}) {
    return Future.value(gifs);
  }
}
