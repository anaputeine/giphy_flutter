import 'package:flutter_test/flutter_test.dart';
import 'package:giphy_flutter/domain/gif/model/gif.dart';
import 'package:giphy_flutter/presentation/feature/search/bloc/gif_cubit.dart';
import '../../../../data/repository/fake_gif_repository.dart';
import 'package:bloc_test/bloc_test.dart';

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

List<Gif> gifsDouble = [...gifs, ...gifs];

void main() {
  late GifCubit cubit;
  late FakeGifRepository fakeGifRepository;
  setUp(() {
    fakeGifRepository = FakeGifRepository();
    cubit = GifCubit(gifRepository: fakeGifRepository);
  });

  group('gifs', () {
    blocTest(
      'empty when created',
      build: () => cubit,
      verify: (cubit) {
        expect(cubit.state.gifs, isEmpty);
        expect(cubit.state.isLoading, false);
        expect(cubit.state.isLoadingMore, false);
        expect(cubit.state.isError, false);
        expect(cubit.state.hasReachedEnd, false);
        expect(cubit.state.offset, 0);
      },
    );
    blocTest(
      'full when loadGifs is called',
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadGifs(query: "", lang: "");
      },
      verify: (cubit) {
        expect(cubit.state.gifs, gifs);
        expect(cubit.state.isLoading, false);
        expect(cubit.state.isLoadingMore, false);
        expect(cubit.state.isError, false);
        expect(cubit.state.hasReachedEnd, false);
        expect(cubit.state.offset, gifs.length);
      },
    );
    blocTest(
      'bigger when loadMore is called',
      build: () => cubit,
      act: (cubit) async {
        await cubit.loadGifs(query: "", lang: "");
        await cubit.loadMore();
      },
      verify: (cubit) {
        expect(cubit.state.gifs, gifsDouble);
        expect(cubit.state.isLoading, false);
        expect(cubit.state.isLoadingMore, false);
        expect(cubit.state.isError, false);
        expect(cubit.state.hasReachedEnd, false);
        expect(cubit.state.offset, gifsDouble.length);
      },
    );
  });
}
