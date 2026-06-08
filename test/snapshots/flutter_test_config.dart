import 'dart:io';

import 'package:alchemist/alchemist.dart';
import 'package:domain/locale/repository/locale_repository.dart';
import 'package:domain/theme/repository/theme_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/di/di.dart';

import '../fakes/fake_locale_repository.dart';
import '../fakes/fake_theme_repository.dart';

Future<void> testExecutable(AsyncCallback testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();

  await _loadFonts();

  diContainer.registerLazySingleton<ThemeRepository>(
        () => FakeThemeRepository(),
  );
  diContainer.registerLazySingleton<LocaleRepository>(
        () => FakeLocaleRepository(),
  );

  return AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      platformGoldensConfig: PlatformGoldensConfig(
        filePathResolver: (fileName, extension) => 'goldens/$fileName.png',
      ),
      ciGoldensConfig: const CiGoldensConfig(enabled: false),
    ),
    run: testMain,
  );
}

Future<void> _loadFonts() async {
  final fontLoader = FontLoader('Inter')
    ..addFont(_readFont('resources/fonts/Inter-Regular.ttf'))
    ..addFont(_readFont('resources/fonts/Inter-Medium.ttf'))
    ..addFont(_readFont('resources/fonts/Inter-SemiBold.ttf'))
    ..addFont(_readFont('resources/fonts/Inter-SemiBoldItalic.ttf'))
    ..addFont(_readFont('resources/fonts/Inter-Bold.ttf'));
  await fontLoader.load();
}

Future<ByteData> _readFont(String path) async {
  final bytes = await File(path).readAsBytes();

  return ByteData.view(bytes.buffer);
}