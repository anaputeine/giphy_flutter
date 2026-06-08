import 'package:flutter/cupertino.dart';
import '../gif/model/gif.dart';

abstract class AppCoordinator {
  void openGifDetails(BuildContext context, Gif gif);
}