import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:giphy_flutter/presentation/app/bloc/app_cubit.dart';
import 'data/firebase/service/fb_service.dart';
import 'data/gif/api/gif_api.dart';
import 'data/network/repository/network_connectivity_repository.dart';
import 'data/gif/repository/network_gif_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'domain/gif/repository/gif_repository.dart';
import 'firebase_options.dart';
import 'presentation/app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.landscapeLeft]);

  final gifDio = Dio(BaseOptions(baseUrl: 'https://service.giphy.com/v1/gifs'));
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
  final FbService fbService = FbService();

  final networkGifRepository = NetworkGifRepository(gifApiClient: gifApiClient, fbService: fbService);
  final gifRepositoryProvider = RepositoryProvider<GifRepository>(
    create: (context) => networkGifRepository,
  );

  final connectivityRepository = NetworkConnectivityRepository();
  final connectivityCubitProvider = BlocProvider(
    create: (context) => AppCubit(connectivityRepository),
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        //coordinatorProvider,
        gifRepositoryProvider,
      ],
      child: MultiBlocProvider(providers: [connectivityCubitProvider], child: const MyApp()),
    ),
  );
}
