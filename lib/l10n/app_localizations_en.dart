// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get lang => 'en';

  @override
  String get imported => 'Imported:';

  @override
  String get trending => 'Trending:';

  @override
  String get gifs => 'Gifs';

  @override
  String get searchGif => 'Search GIF...';

  @override
  String get failedToLoad => 'Failed to load';

  @override
  String get noGifsFound => 'No GIFs found';
}
