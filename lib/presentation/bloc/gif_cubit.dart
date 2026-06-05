import '../../domain/repository/gif_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'gif_state.dart';

class GifCubit extends Cubit<GifState> {
  static const _pageSize = 25;

  final GifRepository _gifRepository;

  String? _currentQuery;
  String? _lang;
  int _offset = 0;

  GifCubit({
    required this._gifRepository,
  }) : super(
         const GifState(
           gifs: [],
           isLoading: false,
           isLoadingMore: false,
           isError: false,
           hasReachedEnd: false,
         ),
       );

  Future<void> loadGifs({
    required String? query,
    required String lang,
    bool loadMore = false,
  }) async {
    if (state.isLoading) return;

    if (!loadMore) {
      _offset = 0;
      _currentQuery = query;
      _lang = lang;

      emit(
        state.copyWith(
          isLoading: true,
          isError: false,
        ),
      );
    }

    try {
      final gifs = await _gifRepository.getGifs(
        lang: lang,
        query: query,
        offset: _offset,
        limit: _pageSize,
      );

      emit(
        state.copyWith(
          gifs: loadMore ? [...state.gifs, ...gifs] : gifs,
          isLoading: false,
        ),
      );

      _offset += gifs.length;
    } catch (e, st) {
      print(e);
      print(st);

      emit(
        state.copyWith(
          isError: true,
          isLoading: false,
        ),
      );
    }
  }

  Future<void> loadMore() {
    return loadGifs(
      query: _currentQuery,
      lang: _lang ?? 'en',
      loadMore: true,
    );
  }
}
