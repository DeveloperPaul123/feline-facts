
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/foundation.dart';

abstract class BaseNetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfo implements BaseNetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfo({@required this.connectionChecker});
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

}
