import 'package:minakomi/config/app_metrics.dart';
import 'package:flutter/material.dart';

class HeaderChild extends StatelessWidget {
  final bool showLeftIcon;
  final IconData? leftIcon;
  final String title;
  final Function? onPressLeftIcon;
  final Widget? rightIcon;

  const HeaderChild(
      {Key? key,
      this.showLeftIcon = true,
      this.leftIcon,
      required this.title,
      this.onPressLeftIcon,
      this.rightIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppMetrics.paddingHorizotal),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            showLeftIcon
                ? GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      onPressLeftIcon ?? Navigator.pop(context);
                    },
                    child: Container(
                      child: Icon(leftIcon ?? Icons.arrow_back),
                      padding:
                          EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0),
                    ))
                : Container(),
            Expanded(child: Text(title), flex: 1),
            rightIcon ?? Container(),
          ],
        ));
  }
}
