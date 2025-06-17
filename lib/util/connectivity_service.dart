import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { online, offline }

class NetworkStatusService {
  Stream<NetworkStatus> get status async* {
    // Initial check
    final initialResults = await Connectivity().checkConnectivity();
    yield _getStatusFromResults(initialResults);

    // Listen for changes
    yield* Connectivity().onConnectivityChanged.map(_getStatusFromResults);
  }

  NetworkStatus _getStatusFromResults(List<ConnectivityResult> results) {
    // Treat none or empty list as offline
    if (results.isEmpty || results.contains(ConnectivityResult.none)) {
      return NetworkStatus.offline;
    }
    return NetworkStatus.online;
  }
}
