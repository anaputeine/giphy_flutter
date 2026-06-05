import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giphy_flutter/domain/coordinator/gif_coordinator.dart';
import '../l10n/app_localizations.dart';
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
  late final GifCoordinator _gifCoordinator;
  late final GifCubit _cubit;

  final _searchController = TextEditingController();
  Timer? _debouncer;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _gifCoordinator = context.read();
    _cubit = context.read();
    _cubit.loadGifs(lang: "en", query: "67");
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
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: .symmetric(horizontal: 12),
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
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: BlocBuilder<GifCubit, GifState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.isError) {
                  return Center(
                    child: Text(AppLocalizations.of(context)!.failedToLoad),
                  );
                }

                final gifs = state.gifs;

                if (gifs.isEmpty) {
                  return Center(
                    child: Text(AppLocalizations.of(context)!.noGifsFound),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  controller: _scrollController,
                  itemCount: gifs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final gif = gifs[index];

                    return GestureDetector(
                      onTap: () => _gifCoordinator.openGifDetails(context, gif),
                      child: Image.network(
                        gif.url,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
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
}
