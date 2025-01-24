import 'package:connectivity_plus/connectivity_plus.dart';

// class NetworkInfo {
//   Future<bool> get isConnected async {
//     final connectivityResult = await Connectivity().checkConnectivity();
//     return connectivityResult != ConnectivityResult.none;
//   }
// }

abstract class NetworkInfo {
  Future<bool> get isConnected;
}
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  // Constructor to inject the Connectivity dependency
  NetworkInfoImpl([Connectivity? connectivity])
      : _connectivity = connectivity ?? Connectivity();

  @override
  Future<bool> get isConnected async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}

