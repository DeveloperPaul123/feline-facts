import 'package:connectivity_plus/connectivity_plus.dart';

abstract class BaseNetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfo implements BaseNetworkInfo {
  bool connectionStatus = false;
  NetworkInfo();
  @override
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
}
