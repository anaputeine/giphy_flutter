import 'package:flutter/material.dart';
import '../../domain/model/gif.dart';
import '../../l10n/app_localizations.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 24),

            Center(
              child: Image.network(
                gif.url,
                height: 300,
                fit: BoxFit.contain,
              ),
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
        ),
      ),
    );
  }
}
