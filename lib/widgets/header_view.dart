import 'package:flutter/material.dart';
import 'package:minakomi/export.dart';

class HeaderView extends StatelessWidget {
  const HeaderView(
      {Key? key,
      this.iconLeft,
      this.iconRight,
      this.isShowIconLeft = true,
      this.onPressIconLeft,
      this.title,
      this.textAlign,
      this.height})
      : super(key: key);
  final Widget? iconLeft, iconRight;
  final Function()? onPressIconLeft;
  final bool isShowIconLeft;
  final String? title;
  final Alignment? textAlign;
  final double? height;
  @override
  Widget build(BuildContext context) {
    double padding = AppMetrics.paddingHorizotal;
    return SafeArea(
      child: SizedBox(
        height: height ?? AppMetrics.heigthHeader,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (isShowIconLeft)
                    ? Center(
                        child: checkIconLeft(context, padding),
                      )
                    : const SizedBox(
                        width: 40,
                      ),
                (iconRight != null)
                    ? Center(
                        child: Container(
                            height: AppMetrics.heigthHeader,
                            color: Colors.transparent,
                            child: iconRight))
                    : const Padding(
                        padding: EdgeInsets.zero,
                        // padding: EdgeInsets.only(right: padding, left: padding / 5),
                        child: SizedBox(
                          width: 40,
                        ),
                      )
              ],
            ),
            Align(
              alignment: textAlign ?? Alignment.center,
              child: Text(
                title ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppStyles.textSize19(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget checkIconLeft(BuildContext context, double padding) {
    if (iconLeft != null) {
      return Container(
          height: height ?? AppMetrics.heigthHeader,
          color: Colors.transparent,
          child: Padding(
              padding: EdgeInsets.only(left: padding, right: padding / 5),
              child: iconLeft!));
    }
    return GestureDetector(
        onTap: () {
          if (onPressIconLeft != null) {
            onPressIconLeft!();
          } else {
            Navigator.pop(context);
          }
        },
        child: Container(
            height: height ?? AppMetrics.heigthHeader,
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(left: padding, right: padding / 5),
              child: Icon(Icons.arrow_back_ios),
            )));
  }
}
