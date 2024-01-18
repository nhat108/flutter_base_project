import 'package:minakomi/config/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionWidget extends StatefulWidget {
  const AppVersionWidget({Key? key}) : super(key: key);

  @override
  State<AppVersionWidget> createState() => _AppVersionWidgetState();
}

class _AppVersionWidgetState extends State<AppVersionWidget> {
  PackageInfo? packageInfo;
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (packageInfo != null) {
      return Text(
        "${packageInfo!.appName}_${packageInfo!.version}(${packageInfo!.buildNumber})",
        style: AppStyles.textSize16(),
      );
    }
    return Container();
  }
}
