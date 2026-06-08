import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/network/repository/connectivity_repository.dart';

class AppCubit extends Cubit<bool> {
  AppCubit(this._repository) : super(true) {
    _subscription = _repository.connectionStream.listen(emit);
  }

  final ConnectivityRepository _repository;
  late final StreamSubscription<bool> _subscription;

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}