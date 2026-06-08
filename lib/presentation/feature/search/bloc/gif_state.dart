import 'package:equatable/equatable.dart';
import '../../../../domain/gif/model/gif.dart';

class GifState extends Equatable {
  final List<Gif> gifs;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isError;
  final bool hasReachedEnd;
  final String query;
  final String lang;
  final int offset;
  final int pageSize = 25;

  const GifState({
    required this.gifs,
    required this.isLoading,
    required this.isLoadingMore,
    required this.isError,
    required this.hasReachedEnd,
    required this.query,
    required this.lang,
    required this.offset,
  });

  GifState copyWith({
    List<Gif>? gifs,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isError,
    bool? hasReachedEnd,
    String? query,
    String? lang,
    int? offset,
  }) => GifState(
    gifs: gifs ?? this.gifs,
    isLoading: isLoading ?? this.isLoading,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    isError: isError ?? this.isError,
    hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    query: query ?? this.query,
    lang: lang ?? this.lang,
    offset: offset ?? this.offset,
  );

  @override
  List<Object?> get props => [
    gifs,
    isLoading,
    isLoadingMore,
    isError,
    hasReachedEnd,
    query,
    lang,
    offset,
    pageSize,
  ];
}
