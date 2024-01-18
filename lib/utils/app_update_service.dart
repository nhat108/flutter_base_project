import 'package:minakomi/config/app_constrants.dart';
import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';

class AppUpdateService {
  static Future<void> checkAppUpdate(BuildContext context) async {
    final newVersion = NewVersion(
      iOSId: AppConstrants.iosPackageName,
      androidId: AppConstrants.androidPackageName,
    );
    newVersion.showAlertIfNecessary(context: context);
  }
}
