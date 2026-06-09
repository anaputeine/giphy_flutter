import 'package:flutter/material.dart';
import 'package:giphy_flutter/presentation/navigation/routes.dart';
import 'package:go_router/go_router.dart';

import '../../domain/gif/model/gif.dart';
import '../feature/search/search_page.dart';
import '../feature/detail/detail_page.dart';

final rootNavigationKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: rootNavigationKey,
  initialLocation: AppRoutes.search,
  routes: [
    GoRoute(
      path: AppRoutes.search,
      name: 'search',
      builder: (context, state) => SearchPage.withCubit(),
    ),
    GoRoute(
      path: AppRoutes.detail,
      name: 'detail',
      builder: (context, state) {
        final gif = state.extra! as Gif;

        return DetailPage(gif: gif);
      },
    ),
  ],
);