import 'package:flutter/material.dart';

import '../../domain/coordinator/gif_coordinator.dart';
import '../../domain/model/gif.dart';
import '../../presentation/detail_page.dart';

class GifCoordinatorImpl implements GifCoordinator {
  @override
  void openGifDetails(BuildContext context, Gif gif) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DetailPage(gif: gif),
      ),
    );
  }
}