import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../../../../domain/model/gif.dart';
import '../../../../domain/repository/gif_repository.dart';
import 'gif_state.dart';

class GifCubit extends Cubit<GifState> {
  final GifRepository _gifRepository;
  StreamSubscription<InternetStatus>? _internetSubscription;

  GifCubit({
    required this._gifRepository,
  }) : super(
         const GifState(
           gifs: [],
           isLoading: false,
           isLoadingMore: false,
           isError: false,
           hasInternet: true,
           hasReachedEnd: false,
           query: "67",
           lang: 'en',
           offset: 0,
         ),
       ) {
    _listenToInternet();
  }

  void _listenToInternet() {
    _internetSubscription = InternetConnection().onStatusChange.listen((status) {
      emit(
        state.copyWith(
          hasInternet: status == InternetStatus.connected,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _internetSubscription?.cancel();
    return super.close();
  }

  Future<void> loadGifs({
    required String? query,
    required String lang,
  }) async {
    if (!state.hasInternet) {
      emit(
        state.copyWith(
          isError: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        query: query,
        lang: lang,
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
          hasReachedEnd: gifs.length < state.pageSize,
          offset: gifs.length,
        ),
      );
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
    if (state.isLoadingMore || state.hasReachedEnd || !state.hasInternet) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    try {
      final gifs = await _fetchPage();

      emit(
        state.copyWith(
          gifs: [...state.gifs, ...gifs],
          isLoadingMore: false,
          hasReachedEnd: gifs.length < state.pageSize,
          offset: state.offset + gifs.length,
        ),
      );
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
      lang: state.lang,
      query: state.query,
      offset: state.offset,
      limit: state.pageSize,
    );
  }
}
