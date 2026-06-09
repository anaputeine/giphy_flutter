import '../../domain/navigation/app_coordinator.dart';
import '../../domain/gif/model/gif.dart';
import 'app_router.dart';

class AppCoordinatorImpl implements AppCoordinator {
  @override
  void openGifDetails(Gif gif) {
    appRouter.pushNamed(
      'detail',
      extra: gif,
    );
  }
}
