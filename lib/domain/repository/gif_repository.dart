import '../model/gif.dart';

abstract class GifRepository
{
  Future<List<Gif>> getGifs({required String lang,required String? query, required int offset, required int limit});
}