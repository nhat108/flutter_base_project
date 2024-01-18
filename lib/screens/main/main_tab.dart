import 'package:badges/badges.dart';
import 'package:minakomi/utils/app_update_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/home_page/home/home_bloc.dart';
import '../../blocs/notification/list_notification/list_notification_bloc.dart';
import '../../utils/connectivity_service.dart';
import '../../utils/deep_link_service.dart';
import '../../utils/notification_service.dart';
import '../../widgets/double_check_to_close_app.dart';
import '../../widgets/navigator/index.dart';
import 'package:minakomi/export.dart';

class MainTab extends StatefulWidget {
  const MainTab({Key? key}) : super(key: key);
  @override
  _MainTabState createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  List<AppFlow>? appFlows;
  GlobalKey<AdaptiveBottomNavigationScaffoldState>? apdaterKey;
  final DeepLinkService deepLinkService = DeepLinkService();
  final NotificationService notificationService = NotificationService();
  final ConnecttivityService connecttivityService = ConnecttivityService();

  @override
  void initState() {
    super.initState();

    apdaterKey = GlobalKey<AdaptiveBottomNavigationScaffoldState>();
    appFlows = [
      AppFlow(
        title: '',
        iconData: Container(),
        activeIconData: Container(),
        navigatorKey: GlobalKey<NavigatorState>(),
        child: Container(),
      ),
      AppFlow(
        title: '',
        iconData: Container(),
        activeIconData: Container(),
        navigatorKey: GlobalKey<NavigatorState>(),
        child: Container(),
      ),
      AppFlow(
        title: '',
        iconData:
            BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
          return BlocBuilder<ListNotificationBloc, ListNotificationState>(
              builder: (context, state) {
            return Badge(
              showBadge: state.listNotifications!
                      .any((element) => element.isRead == false) &&
                  authState.profileModel != null,
              badgeColor: AppColors.primary,
              position: const BadgePosition(
                end: -2,
                top: -2,
              ),
              child: Container(),
            );
          });
        }),
        activeIconData:
            BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
          return BlocBuilder<ListNotificationBloc, ListNotificationState>(
              builder: (context, state) {
            return Badge(
              showBadge: state.listNotifications!
                      .any((element) => element.isRead == false) &&
                  authState.profileModel != null,
              badgeColor: AppColors.primary,
              position: const BadgePosition(
                end: -2,
                top: -2,
              ),
              child: Container(),
            );
          });
        }),
        navigatorKey: GlobalKey<NavigatorState>(),
        child: Container(),
      ),
      AppFlow(
        title: '',
        iconData: Container(),
        activeIconData: Container(),
        navigatorKey: GlobalKey<NavigatorState>(),
        child: Container(),
      ),
    ];

    if (AppConfig().appEnvironment == AppEnvironment.prod) {
      AppUpdateService.checkAppUpdate(context);
    }
    deepLinkService.init();
    notificationService.settingNotifcation(context);
    connecttivityService.initConnectivity();

    _fetchData();
  }

  @override
  void dispose() {
    deepLinkService.dispose();
    notificationService.dispose();
    connecttivityService.dispose();
    super.dispose();
  }

  _fetchData() async {
    if (BlocProvider.of<AuthBloc>(context).state.profileModel != null) {
      BlocProvider.of<ListNotificationBloc>(context).add(GetListNotification());
    }
  }

  _onMenuItemChange(_, HomeState state) {
    switch (state.currentMenuItem!) {
      case MenuItemType.home:
        break;
      case MenuItemType.discover:
        break;
      case MenuItemType.camera:
        break;
      case MenuItemType.notification:
        if (BlocProvider.of<AuthBloc>(context).state.profileModel != null) {
          BlocProvider.of<ListNotificationBloc>(context)
              .add(GetListNotification());
          BlocProvider.of<ListNotificationBloc>(context)
              .add(ReadAllNotification());
        }
        break;
      case MenuItemType.profile:
        if (BlocProvider.of<AuthBloc>(context).state.profileModel != null) {
          BlocProvider.of<AuthBloc>(context).add(AuthGetProfile());
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (old, next) {
        if (old.currentMenuItem != next.currentMenuItem) {
          return true;
        }
        return false;
      },
      listener: _onMenuItemChange,
      child: DoubleCheckToCloseApp(
        child: AdaptiveBottomNavigationScaffold(
          key: apdaterKey,
          navigationBarItems: appFlows!.map((flow) {
            return BottomNavigationTab(
              bottomNavigationBarItem: BottomNavigationBarItem(
                label: flow.title,
                icon: flow.iconData,
                activeIcon: flow.activeIconData,
                tooltip: '',
              ),
              navigatorKey: flow.navigatorKey,
              initialPageBuilder: (context) => flow.child,
            );
          }).toList(),
        ),
      ),
    );
  }
}
