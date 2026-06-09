import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giphy_flutter/domain/navigation/app_coordinator.dart';
import '../../../l10n/app_localizations.dart';
import 'bloc/gif_cubit.dart';
import 'bloc/gif_state.dart';
import 'dart:async';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();

  static Widget withCubit() => BlocProvider(
    create: (context) => GifCubit(
      gifRepository: context.read(),
    ),
    child: const SearchPage(),
  );
}

class _SearchPageState extends State<SearchPage> {
  late final AppCoordinator _appCoordinator;
  late final GifCubit _cubit;

  final _searchController = TextEditingController();
  Timer? _debouncer;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _appCoordinator = context.read();
    _cubit = context.read();
    _cubit.loadGifs(lang: "en", query: "");
    _searchController.addListener(_debounceSearch);
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.gifs),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          final crossAxisCount = orientation == Orientation.portrait ? 2 : 4;
          return BlocListener<GifCubit, GifState>(
            listener: (context, state) {
              if (state.isError) {
                _showBottomPopup(
                  context: context,
                  message: AppLocalizations.of(context)!.failedToLoad,
                );
              }

              if (!state.isLoading && !state.isError && state.gifs.isEmpty) {
                _showBottomPopup(
                  context: context,
                  message: AppLocalizations.of(context)!.noGifsFound,
                );
              }
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  bottom: PreferredSize(
                    preferredSize: .fromHeight(24),
                    child: Padding(
                      padding: .all(12),
                      child: SearchBar(
                        controller: _searchController,
                        hintText: AppLocalizations.of(context)!.searchGif,
                        onSubmitted: (query) {
                          _debouncer?.cancel();
                          _performSearch();
                        },
                        leading: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                BlocBuilder<GifCubit, GifState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: 500,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    }

                    if (state.isError) {
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: 500,
                          child: Center(
                            child: Image.asset('assets/error.gif'),
                          ),
                        ),
                      );
                    }

                    final gifs = state.gifs;
                    if (gifs.isEmpty) {
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: 500,
                          child: Center(
                            child: Image.asset('assets/empty.gif'),
                          ),
                        ),
                      );
                    }
                    return SliverGrid.builder(
                      itemCount: gifs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final gif = gifs[index];

                        return GestureDetector(
                          onTap: () => _appCoordinator.openGifDetails(gif),
                          child: _buildGifImage(gif.url),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        },
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(
          Icons.arrow_upward_outlined,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _debouncer?.cancel();
    super.dispose();
  }

  void _debounceSearch() {
    _debouncer?.cancel();

    _debouncer = Timer(const Duration(seconds: 1), () {
      final query = _searchController.text.trim();

      if (query.isEmpty) {
        return;
      }

      _cubit.loadGifs(lang: AppLocalizations.of(context)!.lang, query: query);
    });
  }

  void _performSearch() {
    _cubit.loadGifs(lang: AppLocalizations.of(context)!.lang, query: _searchController.text);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;

    if (position.pixels > position.maxScrollExtent * 0.8) {
      _cubit.loadMore();
    }
  }

  void _showBottomPopup({required BuildContext context, required String message}) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 3),
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          position: FlashPosition.bottom,
          content: Text(
            message,
            style: TextStyle(color: Colors.black),
          ),
        );
      },
    );
  }

  Widget _buildGifImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      return Placeholder();
    }

    return Image.network(
      imagePath,
      fit: BoxFit.cover,
    );
  }
}
