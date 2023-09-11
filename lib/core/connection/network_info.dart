// import 'package:internet_connection_checker/internet_connection_checker.dart';

// abstract class NetworkInfo {
//   Future<bool> get isConnected;
// }

// class NetworkInfoImpl implements NetworkInfo {
//   final InternetConnectionChecker internetConnectionChecker;
//   NetworkInfoImpl({required this.internetConnectionChecker});
  
//   @override
//   Future<bool> get isConnected => internetConnectionChecker.hasConnection;
// }

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<ConnectivityResult> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;
  NetworkInfoImpl(this._connectivity);
  
  @override
  Future<ConnectivityResult> get isConnected => _connectivity.checkConnectivity();
}
