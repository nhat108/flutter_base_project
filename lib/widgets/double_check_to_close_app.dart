import 'package:minakomi/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class DoubleCheckToCloseApp extends StatefulWidget {
  final Widget child;

  const DoubleCheckToCloseApp({Key? key, required this.child})
      : super(key: key);
  @override
  _DoubleCheckToCloseAppState createState() => _DoubleCheckToCloseAppState();
}

class _DoubleCheckToCloseAppState extends State<DoubleCheckToCloseApp> {
  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        (currentBackPressTime != null &&
            now.difference(currentBackPressTime!) >
                const Duration(seconds: 2))) {
      currentBackPressTime = now;
      Helper.showToast('key_press_again_to_exit_app'.tr());
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: widget.child,
    );
  }
}
