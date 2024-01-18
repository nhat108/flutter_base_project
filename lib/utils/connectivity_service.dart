import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import '../config/app_colors.dart';
import 'notification_service.dart';

class ConnecttivityService {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isChecking = true;
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      _connectionStatus = result;
      isChecking = false;
    } catch (e) {
      print(e);
      isChecking = false;
      return;
    }
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    print(result);
    if (isChecking == false) {
      if (result == ConnectivityResult.none) {
        NotificationService.showNotificationBottom(
            title: 'key_internet_error'.tr());
      }
      if ([ConnectivityResult.mobile, ConnectivityResult.wifi]
              .contains(result) &&
          _connectionStatus == ConnectivityResult.none) {
        print('reconnecting');
        NotificationService.showNotificationBottom(
            title: 'key_internet_error'.tr());
        print("reconnecting");
        NotificationService.showNotificationBottom(
          title: 'key_reconnecting'.tr(),
          color: AppColors.grey5,
        );
        //TODO fetch new data
      }
    }
    _connectionStatus = result;
  }

  dispose() {
    _connectivitySubscription.cancel();
  }
}
