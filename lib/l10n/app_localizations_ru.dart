// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get lang => 'ru';

  @override
  String get imported => 'Импортировано:';

  @override
  String get trending => 'В тренде:';

  @override
  String get gifs => 'GIF-файлы';

  @override
  String get searchGif => 'Поиск GIF...';

  @override
  String get failedToLoad => 'Не удалось загрузить';

  @override
  String get noGifsFound => 'GIF-файлы не найдены';

  @override
  String get noInternetConnection => 'Нет подключения к интернету';
}
