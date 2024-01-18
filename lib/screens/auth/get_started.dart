import 'package:minakomi/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../utils/theme_manager.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GestureDetector(
        onTap: () {
          if (BlocProvider.of<AuthBloc>(context).state.themeData ==
              ThemeManager().lightTheme) {
            BlocProvider.of<AuthBloc>(context)
                .add(AuthChangeTheme(theme: AppConstrants.darkTheme));
          } else {
            BlocProvider.of<AuthBloc>(context)
                .add(AuthChangeTheme(theme: AppConstrants.lightTheme));
          }
        },
        child: Text('zxc',
            style: AppStyles.textSize11(
              color: AppColors.whiteColor,
            )),
      )),
    );
  }
}
