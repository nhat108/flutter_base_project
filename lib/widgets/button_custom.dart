import 'package:flutter/material.dart';
import 'package:minakomi/export.dart';

class ButtonCustom extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final bool isSecondary, isOutLine;
  final double height;
  final double width;
  final Color? textColor, backgroundColor, borderColor;
  final TextStyle? textStyle;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool enabled;
  const ButtonCustom({
    Key? key,
    required this.onPressed,
    required this.title,
    this.isSecondary = false,
    this.height = 0,
    this.width = double.infinity,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.isOutLine = false,
    this.textStyle,
    this.borderRadius = 0,
    this.padding,
    this.enabled = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled
          ? () {
              onPressed();
            }
          : null,
      style: OutlinedButton.styleFrom(
        padding: padding,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        backgroundColor: enabled == false
            ? const Color(0xfff1f1f2)
            : checkBackgroundColor(), // background
        primary: checkBackgroundColor() == Colors.white
            ? Colors.grey
            : Colors.white, // foreground text
        side: enabled == false
            ? const BorderSide(color: Color(0xfff1f1f2))
            : BorderSide(
                color: checkBorderColor(),
              ), // foreground border
      ),
      child: Center(
          child: Text(
        title,
        style: checkTextStyle(context),
      )),
    );
  }

  Color checkBackgroundColor() {
    if (backgroundColor != null) {
      return backgroundColor!;
    } else {
      if (isSecondary) {
        return AppColors.greyWhite;
      } else if (isOutLine) {
        return Colors.transparent;
      } else {
        return AppColors.primary;
      }
    }
  }

  Color checkBorderColor() {
    if (borderColor != null) {
      return borderColor!;
    } else {
      if (isSecondary) {
        return const Color(0xffdbdbdb);
      } else if (isOutLine) {
        return Colors.white;
      } else {
        return AppColors.primary;
      }
    }
  }

  TextStyle checkTextStyle(BuildContext context) {
    if (textStyle != null) {
      return textStyle!;
    }
    return AppStyles.textSize16(
        fontWeight: FontWeight.w600,
        color: enabled == false
            ? const Color(0xff9a9a9a)
            : textColor == null
                ? isSecondary
                    ? AppColors.greyText
                    : Colors.black
                : textColor!);
  }
}
