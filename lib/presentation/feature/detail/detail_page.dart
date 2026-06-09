import 'package:flutter/material.dart';
import '../../../domain/gif/model/gif.dart';
import '../../../l10n/app_localizations.dart';

class DetailPage extends StatelessWidget {
  final Gif gif;

  const DetailPage({super.key, required this.gif});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(gif.title),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const SizedBox(height: 24),

                    Center(
                      child: _buildGifImage(gif.url),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      gif.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                    const SizedBox(height: 24),

                    Text(
                      '${AppLocalizations.of(context)!.imported} ${gif.importDateTime}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '${AppLocalizations.of(context)!.trending} ${gif.trendingDateTime}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 12),
                            _buildGifImage(gif.url),
                          ],
                        ),
                        const SizedBox(width: 24),
                        Column(
                          children: [
                            Text(
                              gif.title,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),

                            const SizedBox(height: 24),

                            Text(
                              '${AppLocalizations.of(context)!.imported} ${gif.importDateTime}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),

                            const SizedBox(height: 8),

                            Text(
                              '${AppLocalizations.of(context)!.trending} ${gif.trendingDateTime}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
        },
      ),
    );
  }

  Widget _buildGifImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      return Placeholder();
    }

    return Image.network(
      imagePath,
      height: 300,
      fit: BoxFit.contain,
    );
  }
}
