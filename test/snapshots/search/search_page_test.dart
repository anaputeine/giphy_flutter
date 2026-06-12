import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giphy_flutter/domain/gif/model/gif.dart';
import 'package:giphy_flutter/presentation/feature/search/bloc/gif_cubit.dart';
import 'package:giphy_flutter/presentation/feature/search/search_page.dart';

import '../../data/repository/fake_gif_repository.dart';
import '../devices.dart';
import '../test_app_wrapper.dart';

void main() {
  goldenTest(
    'Search page',

    fileName: 'search_page',

    pumpBeforeTest: (tester) async {
      await tester.pumpAndSettle();
    },
    builder: () => GoldenTestGroup(
      children: allScenarios.map(
        (device) {
          return GoldenTestScenario(
            name: device.scenarioLabel,

            constraints: BoxConstraints.tight(
              device.size,
            ),

            child: testMaterialWrapper(device)(
              BlocProvider(
                  create: (_) => GifCubit(
                    gifRepository: FakeGifRepository(),
                  ),

                  child: SearchPage(openGifDetails: (Gif gif) => {}),
                ),
              ),
          );
        },
      ).toList(),
    ),
  );
}
