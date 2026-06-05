import 'package:dio/dio.dart';

import 'data/api/gif_api.dart';
import 'presentation/navigation/app_coordinator_implementation.dart';
import 'data/gif/repository/network_gif_repository.dart';
import 'domain/navigation/app_coordinator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'domain/repository/gif_repository.dart';
import 'my_app.dart';

void main() {
  final gifDio = Dio(BaseOptions(baseUrl: 'https://api.giphy.com/v1/gifs'));
  gifDio.interceptors.add(
    LogInterceptor(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
      request: true,
    ),
  );
  final gifApiClient = GifApiClient(gifDio);

  final networkGifRepository = NetworkGifRepository(gifApiClient);
  final gifRepositoryProvider = RepositoryProvider<GifRepository>(
    create: (context) => networkGifRepository,
  );

  final coordinatorProvider = RepositoryProvider<AppCoordinator>(
    create: (_) => AppCoordinatorImpl(),
  );

  runApp(
    MultiRepositoryProvider(
      providers: [coordinatorProvider, gifRepositoryProvider],
      child: const MyApp(),
    ),
  );
}
