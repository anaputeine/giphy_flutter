import 'package:alchemist/alchemist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> testExecutable(AsyncCallback testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();

  return AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      platformGoldensConfig: PlatformGoldensConfig(
        filePathResolver: (fileName, extension) =>
        'goldens/$fileName.png',
      ),
      ciGoldensConfig: const CiGoldensConfig(
        enabled: false,
      ),
    ),
    run: testMain,
  );
}