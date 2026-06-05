import 'package:flutter/material.dart';

import '../../domain/navigation/app_coordinator.dart';
import '../../domain/model/gif.dart';
import '../detail/detail_page.dart';

class AppCoordinatorImpl implements AppCoordinator {
  @override
  void openGifDetails(BuildContext context, Gif gif) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DetailPage(gif: gif),
      ),
    );
  }
}