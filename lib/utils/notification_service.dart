import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:overlay_support/overlay_support.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/home_page/home/home_bloc.dart';
import '../blocs/notification/list_notification/list_notification_bloc.dart';
import '../screens/auth/get_started.dart';
import 'helper.dart';
import 'local_storage.dart';

import 'package:minakomi/export.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  static StreamSubscription? fcmListener;

  static Future<void> showNotification(
      String title, String body, String action) async {
    await FlutterRingtonePlayer.playNotification(
      volume: 0.1,
      looping: false,
    );

    showOverlayNotification(
      (context) {
        return Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              selectNotification('');
            },
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 21, vertical: 12),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppStyles.textSize15(
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            body,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: AppStyles.textSize13(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 3000),
    );
  }

  Future<void> settingNotifcation(BuildContext context) async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await messaging.getToken();
      print("token: $token");
      String medi = await Helper.getMeidDevice();
      final Map<String, dynamic> body = {
        "type": "M",
        "device": Platform.isAndroid ? 'A' : 'I',
        "meid": medi,
        "token": token ?? '',
      };
      context.read<AuthBloc>().add(AuthFCM(body: body));
      fcmListener = FirebaseMessaging.onMessage
          .asBroadcastStream()
          .listen((RemoteMessage message) {
        print("listen notification: ${message.data}");
        if (message.data.containsKey('action') &&
            message.data["action"] == AppConstrants.suspendUser) {
          Helper.dialogErrorMessages(
              barrierDismissible: false,
              context: context,
              onClose: () async {
                await LocalStorage().deleteToken();
                Navigator.popUntil(context, (route) => route.isFirst);
                NavigationService.instance.replace(const GetStarted());
              },
              errorMessage: 'key_account_has_been_suspend_message'.tr());
          return;
        }

        if (message.notification != null) {
          showNotification(message.notification!.title!,
              message.notification!.body!, 'action');
        }
        BlocProvider.of<ListNotificationBloc>(
                NavigationService.instance.navigationKey!.currentContext!)
            .add(GetListNotification());
      });

      setupInteractedMessage();
    }
  }

  static void selectNotification(String payload) {
    // NavigationService.instance.push(const NotificationPage());
    Navigator.popUntil(
        NavigationService.instance.navigationKey!.currentContext!,
        (route) => route.isFirst);
    BlocProvider.of<HomeBloc>(
            NavigationService.instance.navigationKey!.currentContext!)
        .add(ChangeMenuItem(type: MenuItemType.notification));
  }

  Future<void> setupInteractedMessage() async {
    // RemoteMessage? initialMessage =
    //     await FirebaseMessaging.instance.getInitialMessage();
    // if (initialMessage != null) {
    //   _handleMessage(initialMessage);
    // }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    // if (message.data['action'] == 'SOMETHING...') {}
    Navigator.popUntil(
        NavigationService.instance.navigationKey!.currentContext!,
        (route) => route.isFirst);
    BlocProvider.of<HomeBloc>(
            NavigationService.instance.navigationKey!.currentContext!)
        .add(ChangeMenuItem(type: MenuItemType.notification));
    // NavigationService.instance.push(const NotificationPage());
  }

  dispose() async {
    await fcmListener?.cancel();
  }

  static showNotificationBottom(
      {required String title,
      Widget? icon,
      Color? color,
      Duration duration = const Duration(milliseconds: 3000)}) {
    showOverlayNotification(
      (context) {
        return Material(
          color: Colors.transparent,
          child: SafeArea(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  color: color ?? Colors.red[600]!.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 21, vertical: 16),
                margin: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: kBottomNavigationBarHeight + 20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppStyles.textSize15(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      position: NotificationPosition.bottom,
      duration: duration,
    );
  }
}
