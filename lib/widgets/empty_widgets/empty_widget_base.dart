import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../config/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';

class EmptyWidget extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final RefreshController? refreshController;
  final VoidCallback? onRefresh;
  const EmptyWidget(
      {Key? key, this.icon, this.title, this.refreshController, this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var child = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon ?? Icon(Icons.autorenew_rounded),
        const SizedBox(
          height: 14,
        ),
        Text(
          title ?? "key_empty".tr(),
          style: AppStyles.textSize14(
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
    if (refreshController != null) {
      return SmartRefresher(
        controller: refreshController!,
        child: child,
        onRefresh: onRefresh,
      );
    }
    return child;
  }
}
