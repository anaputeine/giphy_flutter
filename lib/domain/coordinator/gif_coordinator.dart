import 'package:flutter/cupertino.dart';
import '../model/gif.dart';

abstract class GifCoordinator {
  void openGifDetails(BuildContext context, Gif gif);
}