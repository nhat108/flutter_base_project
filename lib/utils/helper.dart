import 'dart:io';

import 'package:bot_toast/bot_toast.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:minakomi/export.dart';
import '../screens/auth/get_started.dart';

DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
enum SCREEN { getStarted }
enum ImagePickerType { camera, gallery }

class Helper {
  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em.trim());
  }

  bool weakPassword(String em) {
    return em.trim().length < 8;
  }

  static calAspectRatio({String? aspectRadio}) {
    var context = NavigationService.instance.navigationKey!.currentContext!;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    if (aspectRadio != null) {
      var ratio = double.parse(aspectRadio);
      return ratio;
      // if (ratio == 1) {
      //   return ratio;
      // }

      // var result = screenWidth / (screenHeight / ratio);
      // return result;
    }
    return (screenWidth / screenHeight);
  }

  static void dialogLoading(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        useRootNavigator: true,
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(20),
              child: const CircularProgressIndicator(
                backgroundColor: Colors.black,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          );
        });
  }

  static void dialogSuccessMessages({
    required BuildContext context,
    String? title,
    String message = '',
    Function? onClose,
    bool isShowSecondButton = false,
    Function? onPressPrimaryButton,
    onPressSecondButton,
    String? labelPrimary,
    labelSecondary,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CustomDialog(
              title: title ?? 'key_success'.tr(),
              descriptions: message,
              onClose: onClose,
              isShowSecondButton: isShowSecondButton,
              onPressPrimaryButton: onPressPrimaryButton,
              onPressSecondButton: onPressSecondButton,
              labelPrimary: labelPrimary,
              labelSecondary: labelSecondary,
            ));
  }

  static void showActionDialog({
    required BuildContext context,
    required String title,
    required String message,
    required Function onClose,
    required Function onConfirm,
    String? labelPrimary,
    String? labelSecondary,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CustomDialog(
              title: title,
              descriptions: message,
              onClose: onClose,
              isShowSecondButton: true,
              onPressPrimaryButton: onConfirm,
              onPressSecondButton: onClose,
              labelPrimary: labelPrimary,
              labelSecondary: labelSecondary,
            ));
  }

  static Future<String> getMeidDevice() async {
    String meid = '';
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidDevice = await deviceInfoPlugin.androidInfo;
        meid = androidDevice.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosDevice = await deviceInfoPlugin.iosInfo;
        meid = iosDevice.identifierForVendor;
      }
    } on PlatformException {
      print('Error:' 'Failed to get platform version.');
    }
    return meid;
  }

  static showToast(String message) {
    return BotToast.showCustomText(
        onlyOne: true,
        duration: const Duration(milliseconds: 1500),
        toastBuilder: (textCancel) => Align(
              alignment: const Alignment(0, 0.8),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.greyColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: AppStyles.textSize12(),
                    ),
                  )),
            ));
  }

  static Future<bool> requestPermissionsCamera() async {
    var permission = await Permission.camera.status;

    if (permission != PermissionStatus.granted) {
      await Permission.camera.request();
      permission = await Permission.camera.status;
    }

    return permission == PermissionStatus.granted;
  }

  static Future<File?> pickImage(
    BuildContext context,
    ImagePickerType type,
  ) async {
    try {
      bool isGranted = true;
      if (type == ImagePickerType.camera) {
        isGranted = await requestPermissionsCamera();
      }
      if (isGranted) {
        final imageFile = await ImagePicker().pickImage(
            source: type == ImagePickerType.camera
                ? ImageSource.camera
                : ImageSource.gallery,
            imageQuality: 80);
        if (imageFile != null) {
          return File(imageFile.path);
        }
        return null;
      } else {
        dialogErrorMessages(
          context: context,
          errorMessage: 'notPerAccessCamera'.tr(),
          isShowSecondButton: true,
          labelPrimary: 'key_go_to_setting'.tr(),
          onPressPrimaryButton: () {
            openAppSettings();
          },
        );
        return null;
      }
    } catch (error) {
      if (type == ImagePickerType.camera) {
        await requestPermissionsCamera();
      }
      PlatformException e = error as PlatformException;
      if (e.code == 'photo_access_denied') {
        dialogErrorMessages(
          context: context,
          errorMessage: 'notPerAccessPhoto'.tr(),
          isShowSecondButton: true,
          labelPrimary: 'key_go_to_setting'.tr(),
          onPressPrimaryButton: () {
            openAppSettings();
          },
        );
      } else if (e.code == 'camera_access_denied') {
        dialogErrorMessages(
          context: context,
          errorMessage: 'notPerAccessCamera'.tr(),
          isShowSecondButton: true,
          labelPrimary: 'key_go_to_setting'.tr(),
          onPressPrimaryButton: () {
            openAppSettings();
          },
        );
      }
    }
  }

  static launchUrl(String url) async {
    if (url.contains('https://') == false || url.contains('http://') == false) {
      url = 'https://$url';
    }
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        showToast('key_counld_not_launch'.tr() + " $url");
      }
    } catch (e) {
      showToast('key_counld_not_launch'.tr() + " $url");
    }
  }

  static String formatDateTime(String dateTime, {String? fomat}) {
    return DateFormat(fomat ?? "yyyy/MM/dd").format(DateTime.parse(dateTime));
  }

  static DateTime formatStringToDateTime(String dateTime, {String? format}) {
    return DateFormat(format ?? "yyyy/MM/dd").parse(dateTime);
  }

  static String formatUtcTime(
      {required String dateUtc,
      required format,
      BuildContext? context,
      String? newPattern}) {
    try {
      var dateTime = DateFormat(
        newPattern ?? "yyyy-MM-dd'T'HH:mm:ss",
      ).parseUtc(dateUtc);
      var dateLocal = dateTime.toLocal();

      return DateFormat(
              format,
              context == null || format == 'dd/MM/yy'
                  ? "en"
                  : context.locale.languageCode)
          .format(dateLocal);
    } catch (e) {
      return '-:--';
    }
  }

  static String convertTimeToHourOrDay(
      {required String dateTime, required String format}) {
    try {
      var date = DateFormat(format).parse(dateTime);

      final x = DateFormat(format).format(DateTime.now());
      final dateNow = DateFormat(format).parse(x);
      final day = dateNow.difference(date).inDays;
      if (day == 0) {
        final hours = dateNow.difference(date).inHours;
        if (hours == 0) {
          final minutes = dateNow.difference(date).inMinutes;
          if (minutes == 0) {
            return "${dateNow.difference(date).inSeconds}sec";
          } else {
            return "${minutes}min";
          }
        } else {
          return "${hours.abs()}h";
        }
      }
      return "${dateNow.difference(date).inDays}d";
    } catch (e) {
      return "-:--";
    }
  }

  static String formatBigNumber(int? number) {
    try {
      return NumberFormat.compact().format(number);
    } catch (e) {
      return number == null ? "0" : "$number";
    }
  }

  static void dialogErrorMessages(
      {BuildContext? context,
      String? title,
      required String errorMessage,
      String errorCode = '',
      Function? onClose,
      bool isShowSecondButton = false,
      Function? onPressPrimaryButton,
      onPressSecondButton,
      String? labelPrimary,
      bool barrierDismissible = false,
      labelSecondary,
      SCREEN? screen = SCREEN.getStarted}) {
    context ??= NavigationService.instance.navigationKey!.currentContext;
    showDialog(
        context: context!,
        barrierDismissible: barrierDismissible,
        builder: (context) => CustomDialog(
              title: title ?? "key_error".tr(),
              descriptions: errorMessage,
              onClose: () {
                if (onClose != null) {
                  onClose();
                }
                if (errorCode == 'AUTH_5' && screen != SCREEN.getStarted) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  NavigationService.instance
                      .navigatePopUtil(const GetStarted());
                }
              },
              isShowSecondButton: isShowSecondButton,
              onPressPrimaryButton: onPressPrimaryButton,
              onPressSecondButton: onPressSecondButton,
              labelPrimary: labelPrimary,
              labelSecondary: labelSecondary,
            ));
  }
}
