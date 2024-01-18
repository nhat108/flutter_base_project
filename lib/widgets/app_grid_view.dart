import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppGridView extends StatefulWidget {
  final List data;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final int crossAxisCount;
  final double childAspectRatio;
  final List<Widget> renderItem;
  final VoidCallback? onLoadMore;

  const AppGridView(
      {Key? key,
      required this.data,
      required this.renderItem,
      this.crossAxisSpacing = 12,
      this.mainAxisSpacing = 16,
      this.crossAxisCount = 2,
      this.childAspectRatio = 1 / 1.5,
      this.onLoadMore})
      : super(key: key);
  @override
  _AppGridViewState createState() => _AppGridViewState();
}

class _AppGridViewState extends State<AppGridView> {
  final _refreshController = RefreshController();
  late ScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: _refreshController,
        header: WaterDropMaterialHeader(),
        onRefresh: () {
          Future.delayed(const Duration(milliseconds: 1000), () {
            _refreshController.refreshCompleted();
          });
        },
        child: GridView.count(
            controller: controller,
            padding: EdgeInsets.all(16),
            crossAxisSpacing: widget.crossAxisSpacing,
            mainAxisSpacing: widget.mainAxisSpacing,
            crossAxisCount: widget.crossAxisCount,
            childAspectRatio: widget.childAspectRatio,
            children: widget.renderItem));
  }

  void _scrollListener() {
    double extentAfter = controller.position.extentAfter;
    if (widget.onLoadMore != null && extentAfter < 500) {
      widget.onLoadMore!();
    }
  }
}
