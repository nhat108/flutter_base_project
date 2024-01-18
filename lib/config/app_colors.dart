import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../utils/navigator_serivce.dart';

class AppColors {
  static const Color primary = Color(0xffffb41d);
  static const Color greyWhite = Color(0xffF1F1F2);
  static const Color greyText = Color(0xff9A9A9A);
  static const Color greyText2 = Color(0xffa0a0a0);
  static const Color greyText3 = Color(0xff999999);
  static const Color grey4 = Color(0xffaaaaaa);
  static const Color grey5 = Color(0xff878787);
  static const Color borderColor = Color(0xffb5b5b5);
  static const Color backgroundColor = Color(0xff262626);
  static const Color turquoiseColor = Color(0xff46DAC0);
  static const Color turquoiseColor700 = Color(0xff167968);
  static const Color greyWhiteColor = Color(0xffBABABA);
  static const Color greyColor = Color(0xff575757);
  static const Color greyColor700 = Color(0xff676767);
  static const Color greyColorBottomTab = Color(0xff999999);
  static const Color blackColor = Color(0xff000000);
  static const Color blueLight = Color(0xff6E6E81);
  static Color get whiteColor {
    print("########################## build color");
    var context =
        NavigationService.instance.navigationKey!.currentState!.context;
    var themData = BlocProvider.of<AuthBloc>(context).state.themeData;
    print("brihtness is :${themData!.brightness.name}");
    if (themData.brightness == Brightness.dark) {
      return Colors.white;
    }
    return Colors.black;
  }

  static Color backgroundGrey(BuildContext context) {
    var themData = BlocProvider.of<AuthBloc>(context).state.themeData;
    return themData!.colorScheme.background;
    // print("brihtness is :${themData!.brightness.name}");
    // if (themData.brightness == Brightness.dark) {
    //   return Colors.red;
    // }
    // return const Color(0xff262626);
  }
}
