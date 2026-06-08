import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../../domain/network/repository/connectivity_repository.dart';

class NetworkConnectivityRepository implements ConnectivityRepository {
  NetworkConnectivityRepository();

  @override
  Stream<bool> get connectionStream => InternetConnection().onStatusChange.map(
    (status) => status == InternetStatus.connected,
  );
}
