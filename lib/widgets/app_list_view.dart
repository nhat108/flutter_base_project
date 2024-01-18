import 'dart:io';

import 'package:minakomi/widgets/empty_widgets/empty_widget_base.dart';
import 'package:minakomi/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_localization/easy_localization.dart';

import 'error_widget.dart';

class AppListView extends StatefulWidget {
  final List data;
  final Function? onLoadMore;
  final Axis scrollDirection;
  final Function renderItem;
  final bool enablePullDown;
  final bool isNeverScroll;
  final Function? onRefresh;
  final RefreshController refreshController;
  final double height;
  final EdgeInsets? padding;
  final Widget? separator;
  final bool? isLoadMore;
  final ScrollController? scrollController;
  const AppListView({
    Key? key,
    required this.data,
    this.onLoadMore,
    this.scrollDirection = Axis.vertical,
    required this.renderItem,
    this.enablePullDown = true,
    this.isNeverScroll = false,
    this.onRefresh,
    required this.refreshController,
    this.height = 24.0,
    this.padding,
    this.separator,
    this.isLoadMore = false,
    this.scrollController,
  }) : super(key: key);
  @override
  AppListViewState createState() => AppListViewState();
}

class AppListViewState extends State<AppListView> {
  late ScrollController controller;
  @override
  void initState() {
    super.initState();
    if (widget.scrollController != null) {
      controller = widget.scrollController!;
      controller.addListener(_scrollListener);
    } else {
      controller = ScrollController()..addListener(_scrollListener);
    }
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onRefresh != null) {
      return SmartRefresher(
          controller: widget.refreshController,
          enablePullDown: widget.enablePullDown,
          header: Platform.isIOS
              ? const ClassHeaderIndicator()
              : const MaterialClassicHeader(),
          onRefresh: () {
            if (widget.onRefresh != null) {
              widget.onRefresh!();
            }
          },
          child: listView());
    }
    return listView();
  }

  Widget listView() => ListView.separated(
        padding: widget.padding,
        physics: widget.isNeverScroll
            ? const NeverScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
        addAutomaticKeepAlives: true,
        scrollDirection: widget.scrollDirection,
        controller: controller,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == widget.data.length) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return widget.renderItem(widget.data[index], index);
        },
        itemCount:
            widget.isLoadMore! ? widget.data.length + 1 : widget.data.length,
        separatorBuilder: (BuildContext context, int index) {
          return widget.separator ??
              SizedBox(
                height: widget.height,
              );
        },
      );

  void _scrollListener() {
    var triggerFetchMoreSize = controller.position.maxScrollExtent;
    if (widget.onLoadMore != null &&
        controller.position.pixels > triggerFetchMoreSize) {
      widget.onLoadMore!();
    }
  }
}

class AppListViewBloc<T> extends StatefulWidget {
  final bool isLoading;
  final String error;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final VoidCallback onRefresh;
  final Widget? onEmptyWidget;
  final Widget? onErrorWidget;
  final VoidCallback onLoadMore;
  final Widget? separator;
  final ScrollController? scrollController;
  final bool hasReachedMax;
  final bool shrinkWrap;
  final bool addAutomaticKeepAlives;
  final Axis scrollDirection;
  const AppListViewBloc({
    Key? key,
    required this.isLoading,
    required this.error,
    required this.itemCount,
    required this.itemBuilder,
    required this.onRefresh,
    this.onEmptyWidget,
    this.onErrorWidget,
    required this.onLoadMore,
    this.separator,
    this.scrollController,
    required this.hasReachedMax,
    this.shrinkWrap = true,
    this.addAutomaticKeepAlives = true,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);

  @override
  State<AppListViewBloc> createState() => _AppListViewBlocState();
}

class _AppListViewBlocState extends State<AppListViewBloc> {
  final RefreshController _emptyRefreshController = RefreshController();
  final RefreshController _refreshController = RefreshController();
  final RefreshController _errorRefreshController = RefreshController();
  late ScrollController _scrollcontroller;
  @override
  void initState() {
    super.initState();
    if (widget.scrollController != null) {
      _scrollcontroller = widget.scrollController!;
      _scrollcontroller.addListener(_scrollListener);
    } else {
      _scrollcontroller = ScrollController()..addListener(_scrollListener);
    }
  }

  @override
  void didUpdateWidget(covariant AppListViewBloc oldWidget) {
    if (widget.isLoading == false) {
      if (_emptyRefreshController.isRefresh) {
        _emptyRefreshController.refreshCompleted();
      }
      if (_refreshController.isRefresh) {
        _refreshController.refreshCompleted();
      }
      if (_errorRefreshController.isRefresh) {
        _errorRefreshController.refreshCompleted();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  void _scrollListener() {
    var triggerFetchMoreSize = _scrollcontroller.position.maxScrollExtent;
    if (widget.hasReachedMax == false &&
        _scrollcontroller.position.pixels > triggerFetchMoreSize) {
      widget.onLoadMore();
    }
  }

  @override
  void dispose() {
    _scrollcontroller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (widget.isLoading && widget.itemCount == 0) {
        return LoadingWidget();
      }
      if (widget.error.isNotEmpty) {
        return ErrorWidgetCustom(
          error: widget.error,
          refreshController: _errorRefreshController,
          onRefresh: widget.onRefresh,
        );
      }
      if (widget.isLoading == false && widget.itemCount == 0) {
        return EmptyWidget(
          onRefresh: widget.onRefresh,
          refreshController: _emptyRefreshController,
        );
      }
      if (widget.itemCount > 0) {
        return SmartRefresher(
          controller: _refreshController,
          onRefresh: widget.onRefresh,
          child: ListView.separated(
              controller: _scrollcontroller,
              addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
              scrollDirection: widget.scrollDirection,
              shrinkWrap: widget.shrinkWrap,
              itemBuilder: widget.itemBuilder,
              separatorBuilder: (_, index) {
                return widget.separator ?? SizedBox();
              },
              itemCount: widget.itemCount),
        );
      }
      return Container();
    });
  }
}

class ClassHeaderIndicator extends StatelessWidget {
  const ClassHeaderIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClassicHeader(
        refreshingText: 'key_refreshing'.tr(),
        completeText: 'key_refresh_completed'.tr(),
        releaseText: 'key_release_to_refresh'.tr(),
        idleText: 'key_pull_down_refresh'.tr());
  }
}
