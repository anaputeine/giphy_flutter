import 'dart:async';

import 'package:giphy_flutter/domain/network/repository/connectivity_repository.dart';

class FakeConnectivityRepository implements ConnectivityRepository {
  final _controller = StreamController<bool>.broadcast();

  @override
  Stream<bool> get connectionStream => _controller.stream;

  void emit(bool isConnected) {
    _controller.add(isConnected);
  }

  Future<void> dispose() async {
    await _controller.close();
  }
}