import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/gif.dart';
import '../../domain/repository/gif_repository.dart';
import 'gif_state.dart';

class GifCubit extends Cubit<GifState> {
  static const int _pageSize = 25;

  final GifRepository _gifRepository;

  String? _query;
  String _lang = 'en';
  int _offset = 0;

  GifCubit({
    required this._gifRepository,
  }) : super(const GifState(
        gifs: [],
        isLoading: false,
        isLoadingMore: false,
        isError: false,
        hasReachedEnd: false,
      ));

  Future<void> loadGifs({
    required String? query,
    required String lang,
  }) async {
    _query = query;
    _lang = lang;
    _offset = 0;

    emit(
      state.copyWith(
        isLoading: true,
        isError: false,
      ),
    );

    try {
      final gifs = await _fetchPage();

      emit(
        state.copyWith(
          gifs: gifs,
          isLoading: false,
          hasReachedEnd: gifs.length < _pageSize,
        ),
      );

      _offset = gifs.length;
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          isError: true,
        ),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || state.hasReachedEnd) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    try {
      final gifs = await _fetchPage();

      emit(
        state.copyWith(
          gifs: [...state.gifs, ...gifs],
          isLoadingMore: false,
          hasReachedEnd: gifs.length < _pageSize,
        ),
      );

      _offset += gifs.length;
    } catch (_) {
      emit(
        state.copyWith(
          isLoadingMore: false,
          isError: true,
        ),
      );
    }
  }

  Future<List<Gif>> _fetchPage() {
    return _gifRepository.getGifs(
      lang: _lang,
      query: _query,
      offset: _offset,
      limit: _pageSize,
    );
  }
}