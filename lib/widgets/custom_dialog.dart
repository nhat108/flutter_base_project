import 'package:flutter/material.dart';

import 'package:minakomi/export.dart';

class CustomDialog extends StatefulWidget {
  final String title, descriptions;
  final Function? onClose;
  final Function? onPressPrimaryButton;
  final bool? isShowSecondButton;
  final Function? onPressSecondButton;
  final String? labelPrimary, labelSecondary;
  const CustomDialog({
    Key? key,
    required this.title,
    required this.descriptions,
    this.onClose,
    this.isShowSecondButton = false,
    this.onPressSecondButton,
    this.onPressPrimaryButton,
    this.labelPrimary,
    this.labelSecondary,
  }) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppMetrics.paddingHorizotal, vertical: 20),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 24, left: 24),
                child: Center(
                  child: Text(
                    widget.title,
                    style: AppStyles.textSize16(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                  right: 0,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        if (widget.onClose != null) {
                          widget.onClose!();
                        }
                      },
                      child: const Icon(
                        Icons.close,
                        size: 25,
                      ))),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            widget.descriptions,
            style: AppStyles.textSize14(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          ButtonCustom(
            title: widget.labelPrimary ?? "key_ok".tr(),
            borderRadius: 5,
            onPressed: () {
              Navigator.pop(context);
              if (widget.onPressPrimaryButton != null) {
                widget.onPressPrimaryButton!();
              } else {
                if (widget.onClose != null) {
                  widget.onClose!();
                }
              }
            },
          ),
          if (widget.isShowSecondButton!)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: ButtonCustom(
                isOutLine: true,
                borderRadius: 5,
                textColor: AppColors.whiteColor,
                title: widget.labelSecondary ?? "key_cancel".tr(),
                onPressed: () {
                  Navigator.pop(context);
                  if (widget.onPressSecondButton != null) {
                    widget.onPressSecondButton!();
                  }
                },
              ),
            )
        ],
      ),
    );
  }
}
