import 'package:equatable/equatable.dart';
import '../../../domain/model/gif.dart';

class GifState extends Equatable {
  final List<Gif> gifs;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isError;
  final bool hasReachedEnd;

  const GifState({
    required this.gifs,
    required this.isLoading,
    required this.isLoadingMore,
    required this.isError,
    required this.hasReachedEnd,
  });

  GifState copyWith({
    List<Gif>? gifs,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isError,
    bool? hasReachedEnd,
  }) => GifState(
    gifs: gifs ?? this.gifs,
    isLoading: isLoading ?? this.isLoading,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    isError: isError ?? this.isError,
    hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
  );

  @override
  List<Object?> get props => [gifs, isLoading, isLoadingMore, isError, hasReachedEnd];
}
