import 'package:flutter/material.dart';
import 'package:giphy_flutter/presentation/feature/search/search_page.dart';

import 'l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SearchPage.withCubit(),
      builder: (_, widget) => Stack(
        children: [
          ?widget,
            // Text(' ni connected'),
        ],
      )
    );
  }
}
