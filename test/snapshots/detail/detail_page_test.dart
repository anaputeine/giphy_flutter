import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:giphy_flutter/domain/gif/model/gif.dart';
import 'package:giphy_flutter/presentation/feature/detail/detail_page.dart';
import '../devices.dart';
import '../test_app_wrapper.dart';

const Gif g = Gif(
  id: "0",
  title: "paper clip claps",
  url: "assets/test.png",
  importDateTime: "2008",
  trendingDateTime: "2008",
);

void main() {
  goldenTest(
    'Detail page',

    fileName: 'detail_page',

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
              const DetailPage(gif: g),
            ),
          );
        },
      ).toList(),
    ),
  );
}
